// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:healthy_heads/colors.dart';
import 'package:provider/provider.dart';

import 'landing_helpers.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    bodyColor() {
      return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.5, 0.9],
                colors: [blackColor, darkGreyColor])),
      );
    }

    return Scaffold(
        backgroundColor: whiteColor,
        body: Stack(
          children: [
            bodyColor(),
            Provider.of<LandingHelpers>(context, listen: false)
                .bodyImage(context),
            Provider.of<LandingHelpers>(context, listen: false)
                .tagLineText(context),
            Provider.of<LandingHelpers>(context, listen: false)
                .mainButton(context),
            Provider.of<LandingHelpers>(context, listen: false)
                .privacyText(context),
          ],
        ));
  }
}
