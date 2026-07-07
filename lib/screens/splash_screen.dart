import 'dart:async';

import 'package:flutter/material.dart';
import 'landing_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (_) => const LandingScreen()),
);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Icon(
              Icons.sticky_note_2_rounded,
              size: 100,
              color: Colors.blue,
            ),

            SizedBox(height: 20),

            Text(
              "Notes Manager",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Text(
              "Capture your ideas anytime",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            SizedBox(height: 50),

            CircularProgressIndicator(),

          ],
        ),
      ),
    );
  }
}