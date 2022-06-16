import 'package:firebase_auth/firebase_auth.dart';
import 'package:fleet/authentication/registeration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';

import '../variables.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[250],
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: GradientColors.blue,
              ),
            ),
            child: Center(
              child: Image.asset(
                'images/logo.png',
                height: 100,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.6,
              margin: EdgeInsets.only(left: 30, right: 30),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: TextField(
                      style: myStyle(18, Colors.black),
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'Enter your email address',
                        prefixIcon: const Icon(Icons.email),
                        hintStyle: myStyle(11, Colors.grey, FontWeight.w500),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: TextField(
                      obscureText: true,
                      style: myStyle(18, Colors.black),
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        prefixIcon: const Icon(Icons.lock),
                        hintStyle: myStyle(11, Colors.grey, FontWeight.w500),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () {
                      try {
                        int count = 0;
                        FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text);
                        Navigator.popUntil(context, (route) {
                          return count++ == 2;
                        });
                      } catch (e) {
                        print(e);
                        var snackbar = SnackBar(
                          content: Text(
                            '${e}',
                            style: myStyle(20),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 45,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: GradientColors.beautifulGreen,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "SIGN IN",
                          style: myStyle(25, Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
