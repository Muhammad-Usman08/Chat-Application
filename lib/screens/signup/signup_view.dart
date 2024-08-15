import 'package:chatapp/components/button.dart';
import 'package:chatapp/components/textField/textfield.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/logo-2.png'),
                Container(
                  margin: const EdgeInsets.only(top: 15, bottom: 29),
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
              ),
              width: 350,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                mainAxisSize: MainAxisSize
                    .min, // Ensure Column takes only the minimum height needed
                children: [
                  const Text(
                    'Sign Up',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 25, bottom: 20),
                    child: const Textfield(
                      text: 'Name',
                      icon: Icon(Icons.person),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: const Textfield(
                      text: 'Email',
                      icon: Icon(Icons.email),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: const Textfield(
                      text: 'Password',
                      icon: Icon(Icons.lock),
                    ),
                  ),
                  Container(
                    // Ensure the button takes full width of the container
                    child: button('Create Account', 350, 50),
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
