// ignore_for_file: avoid_print

import 'package:chatapp/components/button.dart';
import 'package:chatapp/components/textField/textfield.dart';
import 'package:chatapp/screens/home/home_view.dart';
import 'package:chatapp/screens/signup/signup_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  // Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  login(context) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      print(credential);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    emailController.clear();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Red half
            Container(
              height: MediaQuery.of(context).size.height / 2,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xffEC2578),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(35),
                    bottomRight: Radius.circular(35)),
              ),
            ),
            // White half
            Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height / 2,
              width: double.infinity,
              alignment: Alignment.bottomCenter,
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 2),
            ),
            // Main content
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(top: 80),
                          child: Image.asset('assets/logo-2.png')),
                      Container(
                        margin: const EdgeInsets.only(top: 15, bottom: 70),
                        child: const Text(
                          'Deliver Favourite Food',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    width: 350,
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 40, bottom: 70),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Login',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 25, bottom: 20),
                          child: Textfield(
                            text: 'Email',
                            controller: emailController,
                            icon: const Icon(Icons.email),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 40),
                          child: Textfield(
                            text: 'Password',
                            controller: passwordController,
                            icon: const Icon(Icons.lock),
                          ),
                        ),
                        Container(
                          child: button(
                            'Login',
                            350,
                            50,
                            () {
                              login(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 40, bottom: 10),
                  child: const Text(
                    "Don't have an account",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUp()));
                  },
                  child: const Text(
                    'REGISTER',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xffEC2578)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
