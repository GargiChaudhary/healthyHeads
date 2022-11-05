import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:healthy_heads/colors.dart';
import 'package:healthy_heads/screens/chatroom/chatbot.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../services/authentication.dart';
import '../homepage/homepage.dart';
import 'landing_services.dart';
import 'landing_utils.dart';

class LandingHelpers with ChangeNotifier {
  Widget bodyImage(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          image:
              DecorationImage(image: AssetImage('assets/images/yogaGirl.png'))),
    );
  }

  Widget tagLineText(BuildContext context) {
    return Positioned(
      top: 450,
      left: 20,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 370),
        child: RichText(
          text: const TextSpan(
              text: 'Are you a healthy ',
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: whiteColor,
                fontSize: 35,
                fontWeight: FontWeight.w500,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'Head ',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: brownColor,
                    fontSize: 40,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: '?',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: whiteColor,
                    fontSize: 35,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  Widget mainButton(BuildContext context) {
    return Positioned(
      top: 630,
      // ignore: sized_box_for_whitespace
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                emailAuthSheet(context);
              },
              child: Container(
                width: 80,
                height: 40,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.yellow),
                    borderRadius: BorderRadius.circular(10)),
                child: const Icon(
                  Icons.email_outlined,
                  color: Colors.yellow,
                ),
              ),
            ),
            GestureDetector(
              onTap: (() {
                Provider.of<Authentication>(context, listen: false)
                    .signInWithGoogle()
                    .whenComplete(() {
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          child: const HomePage(),
                          type: PageTransitionType.leftToRight));
                });
              }),
              child: Container(
                width: 80,
                height: 40,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.circular(10)),
                child: const Icon(
                  EvaIcons.google,
                  color: Colors.red,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: ChatBot(),
                        type: PageTransitionType.bottomToTop));
              },
              child: Container(
                width: 80,
                height: 40,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(10)),
                child: const Padding(
                  padding: EdgeInsets.only(top: 9.0, left: 13),
                  child: Text(
                    'Guest',
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.blue,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget privacyText(BuildContext context) {
    return Positioned(
      top: 720,
      left: 20,
      right: 20,
      child: Column(
        children: [
          Text(
            "By continuing you agree theSocial's Terms of",
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
          Text(
            "Services & Privacy Policy",
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  // ################################
  emailAuthSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: darkGreyColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 150),
                  child: Divider(
                    thickness: 4,
                    color: whiteColor,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                        color: brownColor,
                        child: const Text(
                          'Log in',
                          style: TextStyle(
                              color: whiteColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Provider.of<LandingServices>(context, listen: false)
                              .logInSheet(context);
                        }),
                    MaterialButton(
                        color: Colors.red,
                        child: const Text(
                          'Sign up',
                          style: TextStyle(
                              color: whiteColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Provider.of<LandingUtils>(context, listen: false)
                              .selectImageOptionsSheet(context);
                        }),
                  ],
                )
              ],
            ),
          );
        });
  }
}
