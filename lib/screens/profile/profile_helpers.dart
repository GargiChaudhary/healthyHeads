import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:healthy_heads/colors.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../services/authentication.dart';
import '../landing/landing_page.dart';

class ProfileHelpers with ChangeNotifier {
  Widget headerProfile(BuildContext context, dynamic snapshot) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // ignore: sized_box_for_whitespace
          Container(
            height: 200,
            width: 180,
            child: Column(
              children: [
                GestureDetector(
                  child: CircleAvatar(
                    backgroundColor: transparent,
                    radius: 60.0,
                    backgroundImage:
                        NetworkImage(snapshot.data.data()['userimage']),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    snapshot.data.data()['username'],
                    style: const TextStyle(
                        color: whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        EvaIcons.email,
                        color: Colors.green,
                        size: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          snapshot.data.data()['useremail'],
                          style: const TextStyle(
                              color: whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: darkBlueColor,
                            borderRadius: BorderRadius.circular(15)),
                        height: 70,
                        width: 80,
                        child: Column(
                          children: const [
                            Text(
                              '0',
                              style: TextStyle(
                                  color: whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28.0),
                            ),
                            Text(
                              'Followers',
                              style: TextStyle(
                                  color: whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: darkBlueColor,
                            borderRadius: BorderRadius.circular(15)),
                        height: 70,
                        width: 80,
                        child: Column(
                          children: const [
                            Text(
                              '0',
                              style: TextStyle(
                                  color: whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28.0),
                            ),
                            Text(
                              'Following',
                              style: TextStyle(
                                  color: whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: darkBlueColor,
                        borderRadius: BorderRadius.circular(15)),
                    height: 70,
                    width: 80,
                    child: Column(
                      children: const [
                        Text(
                          '0',
                          style: TextStyle(
                              color: whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 28.0),
                        ),
                        Text(
                          'Posts',
                          style: TextStyle(
                              color: whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget divider() {
    return const Center(
      child: SizedBox(
        height: 25,
        width: 350,
        child: Divider(
          color: whiteColor,
        ),
      ),
    );
  }

  Widget middleProfile(BuildContext context, dynamic snapshot) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 150,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(2)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Icon(
                  Icons.supervised_user_circle,
                  color: Colors.yellow,
                  size: 16,
                ),
                Text(
                  'Recently Added',
                  style: TextStyle(
                      color: whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: darkGreyColor.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(15)),
            ),
          )
        ],
      ),
    );
  }

  Widget footerProfile(BuildContext context, dynamic snapshot) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.52,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: darkGreyColor.withOpacity(0.4),
            borderRadius: BorderRadius.circular(5)),
        child: Image.asset('assets/images/box.png'),
      ),
    );
  }

  logOutDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            backgroundColor: darkGreyColor,
            title: const Text(
              'Log Out of theSocial?',
              style: TextStyle(
                  color: whiteColor, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            actions: [
              MaterialButton(
                child: const Text(
                  'No',
                  style: TextStyle(
                      color: whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      decoration: TextDecoration.underline,
                      decorationColor: whiteColor),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              MaterialButton(
                color: Colors.red,
                child: const Text(
                  'Yes',
                  style: TextStyle(
                    color: whiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                onPressed: () {
                  Provider.of<Authentication>(context, listen: false)
                      .logOutViaEmail()
                      .whenComplete(() {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            child: const LandingPage(),
                            type: PageTransitionType.bottomToTop));
                    // notifyListeners();
                  });
                },
              )
            ],
          );
        }));
  }
}
