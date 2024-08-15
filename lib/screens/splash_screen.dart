import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

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
