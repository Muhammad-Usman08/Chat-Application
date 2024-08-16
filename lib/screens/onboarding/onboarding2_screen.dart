import 'package:chatapp/components/button.dart';
import 'package:chatapp/screens/signup/signup_view.dart';
import 'package:flutter/material.dart';

class Onboarding2Screen extends StatelessWidget {
  const Onboarding2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
            'assets/fastfood.png',
            width: 400,
          )),
          Container(
            margin: const EdgeInsets.only(top: 100, bottom: 20),
            child: const Text(
              'Foodie is Where Your \nComfort Food Resides',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const Text(
            'Enjoy a fast and smooth food delivery at \nyour doorstep',
            style: TextStyle(fontSize: 13, color: Color(0xff646464)),
            textAlign: TextAlign.center,
          ),
          Container(
              margin: const EdgeInsets.only(top: 100),
              child: button('Next', 150, 45, () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => SignUp()));
              })),
        ],
      ),
    );
  }
}
