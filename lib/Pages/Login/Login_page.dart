import 'package:cta/Pages/Login/SignUp_page.dart';
import 'package:cta/Pages/controller/LoginController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var logincontroller = Get.put(Logincontroller());
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Login",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == '') {
                      return 'Email cant be empty';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white54))),
                  controller: logincontroller.emailcontroller,
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == '') {
                      return 'Password cant be empty';
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "Password",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white54))),
                  controller: logincontroller.passwordcontroller,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  width: 200.w,
                  decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(12)),
                  child: TextButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          logincontroller.signuserin(context);
                        }
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('New User? '),
                    GestureDetector(
                        onTap: () {
                          Get.to(SignupPage());
                        },
                        child: Text(
                          'SignUp ',
                          style: TextStyle(color: Colors.blue),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
