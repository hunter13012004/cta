import 'package:cta/Pages/Login/Login_page.dart';
import 'package:cta/Pages/Login/SignUp_page.dart';
import 'package:cta/Pages/controller/LoginController.dart';
import 'package:cta/Pages/questions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var logincontroller = Get.put(Logincontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Home'),
        actions: [
          logincontroller.isSignedin == false
              ? TextButton(
                  onPressed: () {
                    Get.to(() => LoginPage());
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : Container(),
          logincontroller.isSignedin == false
              ? TextButton(
                  onPressed: () {
                    Get.to(() => SignupPage());
                  },
                  child: Text(
                    'Signup',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : Container(),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to Our App!',
                style: TextStyle(
                  fontSize: 24.0.sp,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0.h),
              Text(
                'Explore our features and get the most out of our services. Click the button below to get started.',
                style: TextStyle(
                  fontSize: 16.0.sp,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40.0.h),
              ElevatedButton(
                onPressed: () {
                  Get.to(() => Questions());
                },
                child: Text(
                  'Take Assessment',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal: 24.0.w, vertical: 12.0.h),
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
