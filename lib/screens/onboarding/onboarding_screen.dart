import 'package:chatapp/components/button.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
            'assets/product.png',
            width: 400,
          )),
          Container(
            margin: const EdgeInsets.only(top: 100, bottom: 20),
            child: const Text(
              'Track your Comfort \nFood here',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const Text(
            'Here You Can find a chef or dish for every \ntaste and color. Enjoy!',
            style: TextStyle(fontSize: 13, color: Color(0xff646464)),
            textAlign: TextAlign.center,
          ),
          button('Next' , 150 , 45),
        ],
      ),
    );
  }
}
