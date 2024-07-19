import 'dart:convert';
import 'package:cta/Pages/Login/Login_page.dart';
import 'package:cta/Pages/controller/LoginController.dart';
import 'package:cta/Pages/resultsPage/Quiz_Result_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Questions extends StatefulWidget {
  const Questions({super.key});

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  var logincontroller = Get.put(Logincontroller());
  int _currentQuestionIndex = 0;
  int _totalScore = 0;
  int? _selectedOption;
  List<String> finaloptions = [];
  List responseData = [];
  List<int> userAnswers = [];
  List<String> shuffledoptions = [];
  bool issignedup = false;

  void fetchApiData() async {
    final response = await http.get(Uri.parse(
        'https://opentdb.com/api.php?amount=10&category=27&difficulty=easy&type=multiple'));
    var data = json.decode(response.body)['results'];

    setState(() {
      responseData = data;
      shuffleoption();
    });
  }

  void calculateScore() {
    for (int i = 0; i < userAnswers.length; i++) {
      if (userAnswers[i] == 0) {
        _totalScore++;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchApiData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Center(
        child: Text(responseData.isNotEmpty
            ? responseData[_currentQuestionIndex]['question']
            : ''),
      ),
      SizedBox(
        height: 20.h,
      ),
      Column(
        children: shuffledoptions.map((option) {
          return RadioListTile(
            title: Text(option),
            value: shuffledoptions.indexOf(option),
            groupValue: _selectedOption,
            onChanged: (val) {
              setState(() {
                _selectedOption = val as int;
              });
            },
          );
        }).toList(),
      ),
      SizedBox(
        height: 20.h,
      ),
      ElevatedButton(
        onPressed: () {
          userAnswers.add(_selectedOption ?? 0);
          if (_currentQuestionIndex < responseData.length - 1) {
            setState(() {
              _currentQuestionIndex++;
              _selectedOption = null;
              shuffleoption();
            });
          } else if (logincontroller.isSignedin == true) {
            calculateScore();
            Get.offAll(
                () => QuizResultsPage(quizResults: _totalScore.toString()));
          } else {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  Text('Please Sign in First to See results '),
                            ),
                            TextField(
                              decoration: InputDecoration(hintText: 'Email'),
                              controller: logincontroller.emailcontroller,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                              obscureText: true,
                              decoration: InputDecoration(hintText: 'password'),
                              controller: logincontroller.passwordcontroller,
                            ),
                            GestureDetector(
                              onTap: () async {
                                await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: logincontroller
                                            .emailcontroller.text
                                            .trim(),
                                        password: logincontroller
                                            .passwordcontroller.text
                                            .trim());

                                setState(() {
                                  logincontroller.isSignedin = true;
                                });
                                if (logincontroller.isSignedin == true) {
                                  Get.offAll(() => QuizResultsPage(
                                      quizResults: _totalScore.toString()));
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.white,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Text('SignIn ')),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            );
          }
        },
        child: Text('Next'),
      ),
    ])));
  }

  void shuffleoption() {
    if (responseData.isNotEmpty) {
      List<String> options = [
        responseData[_currentQuestionIndex]['correct_answer'],
        ...(responseData[_currentQuestionIndex]["incorrect_answers"] as List)
      ];
      options.shuffle();
      setState(() {
        shuffledoptions = options;
      });
    }
  }
}
