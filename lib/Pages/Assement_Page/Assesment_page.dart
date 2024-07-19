import 'package:cta/Pages/controller/LoginController.dart';
import 'package:cta/Pages/model/quiz_model.dart';
import 'package:cta/Pages/resultsPage/Quiz_Result_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AssessmentPage extends StatefulWidget {
  const AssessmentPage({Key? key}) : super(key: key);

  @override
  State<AssessmentPage> createState() => _AssessmentPageState();
}

class _AssessmentPageState extends State<AssessmentPage> {
  var loginController = Get.put(Logincontroller());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  int _currentQuestionIndex = 0;
  int _totalScore = 0;
  int? _selectedOption;
  bool isSignUp = false;
  List responseData = [];

  void _answerQuestion(List<QuizQuestion> questions) {
    if (_selectedOption != null) {
      setState(() {
        if (_currentQuestionIndex < questions.length) {
          // Find the correct answer index
          final correctAnswer = questions[_currentQuestionIndex].correctAnswer;
          final options = [
            ...questions[_currentQuestionIndex].incorrectAnswers,
            correctAnswer,
          ];
          final correctAnswerIndex = options.indexOf(correctAnswer);

          if (_selectedOption == correctAnswerIndex) {
            _totalScore += 1;
          }

          _currentQuestionIndex++;
          _selectedOption = null;

          // If all questions are answered, navigate to results page
          if (_currentQuestionIndex >= questions.length) {
            Get.offAll(QuizResultsPage(
              quizResults: 'The total score is $_totalScore',
            ));
          }
        }
      });
    }
  }

  void _toggleSignUp() {
    setState(() {
      isSignUp = !isSignUp;
    });
  }

  Future<void> _signIn() async {
    if (formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        setState(() {
          loginController.isSignedin = true;
        });
        Get.offAll(QuizResultsPage(
          quizResults: 'The total score is $_totalScore',
        ));
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'An error occurred')),
        );
      }
    }
  }

  Future<void> _signUp() async {
    if (formKey.currentState!.validate()) {
      if (passwordController.text != confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Passwords do not match')),
        );
        return;
      }
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        setState(() {
          loginController.isSignedin = true;
        });
        Get.offAll(QuizResultsPage(
          quizResults: 'The total score is $_totalScore',
        ));
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'An error occurred')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assessment'),
      ),
      body: FutureBuilder<List<QuizQuestion>>(
        future: loginController.getQuizQuestion(), // Call the API method
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No quizzes available'));
          } else {
            final List<QuizQuestion> questions = snapshot.data!;
            return _currentQuestionIndex < questions.length
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          questions[_currentQuestionIndex].question,
                          style: TextStyle(fontSize: 20.0.sp),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20.0.h),
                        Column(
                          children: questions[_currentQuestionIndex]
                              .incorrectAnswers
                              .asMap()
                              .entries
                              .map((entry) {
                            int index = entry.key;
                            String option = entry.value;
                            return RadioListTile<int>(
                              title: Text(option),
                              value: index,
                              groupValue: _selectedOption,
                              onChanged: (int? value) {
                                setState(() {
                                  _selectedOption = value;
                                });
                              },
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 20.0.h),
                        ElevatedButton(
                          onPressed: _selectedOption == null
                              ? null
                              : () {
                                  _answerQuestion(questions);
                                },
                          child: Text('Next'),
                        ),
                      ],
                    ),
                  )
                : loginController.isSignedin
                    ? Center(
                        child: Text('Your total Score is $_totalScore'),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'You need to login before seeing your results',
                              ),
                              SizedBox(height: 20.h),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Email can\'t be empty';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black54),
                                  ),
                                ),
                                controller: emailController,
                              ),
                              SizedBox(height: 20.h),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Password can\'t be empty';
                                  }
                                  return null;
                                },
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black54),
                                  ),
                                ),
                                controller: passwordController,
                              ),
                              if (isSignUp)
                                Column(
                                  children: [
                                    SizedBox(height: 20.h),
                                    TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Confirm Password can\'t be empty';
                                        }
                                        return null;
                                      },
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        hintText: "Confirm Password",
                                        border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black54),
                                        ),
                                      ),
                                      controller: confirmPasswordController,
                                    ),
                                  ],
                                ),
                              SizedBox(height: 20.h),
                              ElevatedButton(
                                onPressed: isSignUp ? _signUp : _signIn,
                                child: Text(isSignUp ? 'Sign Up' : 'Login'),
                              ),
                              TextButton(
                                onPressed: _toggleSignUp,
                                child: Text(
                                  isSignUp
                                      ? 'Already have an account? Login'
                                      : 'Don\'t have an account? Sign Up',
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
          }
        },
      ),
    );
  }
}
