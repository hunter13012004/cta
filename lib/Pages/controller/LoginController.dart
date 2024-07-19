import 'package:cta/Pages/Assement_Page/Assesment_page.dart';
import 'package:cta/Pages/model/quiz_model.dart';
import 'package:cta/Pages/questions.dart';
import 'package:cta/service/api_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Logincontroller extends GetxController {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController confirmpasswordcontroller =
      TextEditingController();

  bool isSignedin = false;

  // Initialize the ApiService with the API endpoint
  final ApiService apiService = ApiService();
  final List<QuizQuestion> questions = [];
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<List<QuizQuestion>> getQuizQuestion() async {
    final response = await apiService.fetchQuizQuestions();
    questions.addAll(response);
    return questions;
  }

  void signuserin(BuildContext context) {
    String email = emailcontroller.text.trim();
    String password = passwordcontroller.text.trim();
    try {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        isSignedin = true;
        update();
        Get.to((Questions()));
        emailcontroller.clear();
        passwordcontroller.clear();
      });
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void sigUserUp(BuildContext context) {
    String email = emailcontroller.text.trim();
    String password = passwordcontroller.text.trim();
    String confirmpassword = confirmpasswordcontroller.text.trim();

    if (password == confirmpassword) {
      try {
        FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) {
          isSignedin = true;
          update();
          Get.to((Questions()));
          emailcontroller.clear();
          passwordcontroller.clear();
          confirmpasswordcontroller.clear();
        });
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } else {
      throw Exception('Passwords do not match');
    }
  }
}
