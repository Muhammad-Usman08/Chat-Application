import 'dart:async';

import 'package:chatapp/screens/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  // ignore: must_call_super
  void initState() {
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const OnboardingScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffffeeda),
        body: Stack(
          children: [
            Center(
              child: Image.asset('assets/logo.png'),
            ),
            Positioned(
              bottom: -12,
              left: -20,
              child: Image.asset(
                'assets/burger.png',
                width: 200,
              ),
            ),
          ],
        ));
  }
}
