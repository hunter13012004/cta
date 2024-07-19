import 'package:cta/Pages/Login/Login_page.dart';
import 'package:cta/Pages/controller/LoginController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  var logincontroller = Get.put(Logincontroller());

  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: GestureDetector(
          onTap: () {},
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "SignUp",
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
                TextFormField(
                  validator: (value) {
                    if (value !=
                        logincontroller.passwordcontroller.text.trim()) {
                      return 'passwords do not match';
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "Confirm Password",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white54))),
                  controller: logincontroller.confirmpasswordcontroller,
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
                        if (formkey.currentState!.validate())
                          logincontroller.sigUserUp(context);
                      },
                      child: Text(
                        'Signup',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already Signed Up? '),
                    GestureDetector(
                        onTap: () {
                          Get.offAll(LoginPage());
                        },
                        child: Text(
                          'Login ',
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
