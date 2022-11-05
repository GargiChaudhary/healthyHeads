import 'dart:async';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../colors.dart';
import 'landing/landing_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
        const Duration(seconds: 1),
        () => Navigator.pushReplacement(
            context,
            PageTransition(
                child: const LandingPage(),
                type: PageTransitionType.leftToRight)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      body: Center(
          child: RichText(
              text: const TextSpan(
                  text: 'healthy',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: whiteColor,
                      fontWeight: FontWeight.w500,
                      // fontWeight: FontWeight.bold,
                      fontSize: 30),
                  children: <TextSpan>[
            TextSpan(
              text: 'Heads',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: brownColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 36),
            )
          ]))),
    );
  }
}
