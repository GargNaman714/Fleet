import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';

import '../variables.dart';

class RegisterationScreen extends StatefulWidget {
  @override
  _RegisterationScreenState createState() => _RegisterationScreenState();
}

class _RegisterationScreenState extends State<RegisterationScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

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
                        hintStyle: myStyle(10, Colors.grey, FontWeight.w300),
                      ),
                    ),
                  ),
                  const SizedBox(
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
                        hintStyle: myStyle(11, Colors.grey, FontWeight.w300),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: TextField(
                      style: myStyle(18, Colors.black),
                      controller: usernameController,
                      decoration: InputDecoration(
                        hintText: 'Enter your username',
                        prefixIcon: const Icon(Icons.person),
                        hintStyle: myStyle(11, Colors.grey, FontWeight.w300),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () {
                      try {
                        FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text)
                            .then((signedUser) {
                          userCollection.doc(signedUser.user!.uid).set({
                            'username': usernameController.text,
                            'email': emailController.text,
                            'password': passwordController.text,
                            'uid': signedUser.user!.uid,
                          });
                        });
                        Navigator.pop(context);
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
                          colors: GradientColors.pink,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "SIGN UP",
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
