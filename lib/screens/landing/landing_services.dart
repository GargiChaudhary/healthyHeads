import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:healthy_heads/colors.dart';
import 'package:healthy_heads/screens/landing/landing_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../services/authentication.dart';
import '../../services/firebase_operations.dart';
import '../homepage/homepage.dart';

class LandingServices with ChangeNotifier {
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();

  showUserImage(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.30,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: darkGreyColor, borderRadius: BorderRadius.circular(15)),
            child: Column(children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 150),
                child: Divider(
                  thickness: 4,
                  color: whiteColor,
                ),
              ),
              CircleAvatar(
                radius: 80.0,
                backgroundColor: transparent,
                backgroundImage: FileImage(
                    Provider.of<LandingUtils>(context, listen: false)
                        .userImage),
              ),
              // ignore: avoid_unnecessary_containers
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                        child: const Text(
                          'Reselect',
                          style: TextStyle(
                              color: whiteColor,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              decorationColor: whiteColor),
                        ),
                        onPressed: () {
                          Provider.of<LandingUtils>(context, listen: false)
                              .pickUserImage(context, ImageSource.gallery);
                        }),
                    MaterialButton(
                        color: brownColor,
                        child: const Text(
                          'Confirm Image',
                          style: TextStyle(
                              color: whiteColor, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Provider.of<FirebaseOperations>(context,
                                  listen: false)
                              .uploadUserImage(context)
                              .whenComplete(() {
                            signUpSheet(context);
                          });
                        }),
                  ],
                ),
              )
            ]),
          );
        });
  }

// #######################################
  logInSheet(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              decoration: const BoxDecoration(
                color: darkGreyColor,
                // borderRadius: BorderRadius.only(
                //     topLeft: Radius.circular(12),
                //     topRight: Radius.circular(12))
              ),
              // height: MediaQuery.of(context).size.height * 0.1,
              // width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 150),
                      child: Divider(
                        thickness: 4,
                        color: whiteColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        controller: userEmailController,
                        decoration: const InputDecoration(
                          hintText: 'Enter email...',
                          hintStyle: TextStyle(
                              color: whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        style: const TextStyle(
                            color: whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        controller: userPasswordController,
                        decoration: const InputDecoration(
                          hintText: 'Enter password...',
                          hintStyle: TextStyle(
                              color: whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        style: const TextStyle(
                            color: whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                    FloatingActionButton(
                      backgroundColor: brownColor,
                      onPressed: (() {
                        if (userEmailController.text.isNotEmpty) {
                          Provider.of<Authentication>(context, listen: false)
                              .logIntoAccount(userEmailController.text,
                                  userPasswordController.text)
                              .whenComplete(() {
                            Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    child: HomePage(),
                                    type: PageTransitionType.bottomToTop));
                          });
                        } else {
                          warningText(context, 'Fill all the data!');
                        }
                      }),
                      child: const Icon(
                        EvaIcons.checkmark,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

// #######################################
  signUpSheet(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              decoration: const BoxDecoration(
                color: darkGreyColor,
                // borderRadius: const BorderRadius.only(
                //     topLeft: Radius.circular(12),
                //     topRight: Radius.circular(12))
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 150),
                      child: Divider(
                        thickness: 4,
                        color: whiteColor,
                      ),
                    ),
                    CircleAvatar(
                      backgroundImage: FileImage(
                          Provider.of<LandingUtils>(context).getUserImage),
                      backgroundColor: Colors.red,
                      radius: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        controller: userNameController,
                        decoration: const InputDecoration(
                          hintText: 'Enter name...',
                          hintStyle: TextStyle(
                              color: whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        style: const TextStyle(
                            color: whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        controller: userEmailController,
                        decoration: const InputDecoration(
                          hintText: 'Enter email...',
                          hintStyle: TextStyle(
                              color: whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        style: const TextStyle(
                            color: whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        controller: userPasswordController,
                        decoration: const InputDecoration(
                          hintText: 'Enter password...',
                          hintStyle: TextStyle(
                              color: whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        style: const TextStyle(
                            color: whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: FloatingActionButton(
                        backgroundColor: Colors.red,
                        onPressed: (() {
                          if (userEmailController.text.isNotEmpty) {
                            Provider.of<Authentication>(context, listen: false)
                                .createAccount(userEmailController.text,
                                    userPasswordController.text)
                                .whenComplete(() {
                              // print('Creating Collection...');
                              Provider.of<FirebaseOperations>(context,
                                      listen: false)
                                  .createUserCollection(context, {
                                'useruid': Provider.of<Authentication>(context,
                                        listen: false)
                                    .getUserUid,
                                'useremail': userEmailController.text,
                                'username': userNameController.text,
                                'userimage': Provider.of<LandingUtils>(context,
                                        listen: false)
                                    .getUserImageUrl
                              });
                            }).whenComplete(() {
                              Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                      child: const HomePage(),
                                      type: PageTransitionType.bottomToTop));
                            });
                          } else {
                            warningText(context, 'Fill all the data!');
                          }
                        }),
                        child: const Icon(
                          EvaIcons.checkmark,
                          color: whiteColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  warningText(BuildContext context, String warning) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
                color: blackColor, borderRadius: BorderRadius.circular(15)),
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text(
                warning,
                style: const TextStyle(
                    color: whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          );
        });
  }
}
