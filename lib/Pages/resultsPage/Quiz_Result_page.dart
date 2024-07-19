import 'package:cta/Pages/questions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class QuizResultsPage extends StatelessWidget {
  final String quizResults;
  const QuizResultsPage({Key? key, required this.quizResults})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Results'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                quizResults,
                style: TextStyle(
                  fontSize: 24.0.sp,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          TextButton(
              onPressed: () {
                Get.offAll(() => Questions());
              },
              child: Text('Restart quiz'))
        ],
      ),
    );
  }
}
