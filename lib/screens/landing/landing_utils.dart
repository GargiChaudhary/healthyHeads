// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:healthy_heads/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'landing_services.dart';
// import 'package:the_social/services/firebase_operations.dart';

class LandingUtils with ChangeNotifier {
  final picker = ImagePicker();
  late File userImage;
  File get getUserImage => userImage;
  late String userImageUrl;
  String? get getUserImageUrl => userImageUrl;

  Future pickUserImage(BuildContext context, ImageSource source) async {
    final pickedUserImage = await picker.pickImage(source: source);
    pickedUserImage == null
        // ignore: avoid_print
        ? print('Select image')
        : userImage = File(pickedUserImage.path);
    // print(userImage?.path);

    Provider.of<LandingServices>(context).showUserImage(context);
    // userImage != null
    //     ? Provider.of<LandingServices>(context).showUserImage(context)
    //     // ignore: avoid_print
    //     : print('Image upload error');
  }

  Future selectImageOptionsSheet(BuildContext context) async {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: darkBlueColor, borderRadius: BorderRadius.circular(12)),
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
                          'Gallery',
                          style: TextStyle(
                              color: whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        onPressed: () {
                          pickUserImage(context, ImageSource.gallery)
                              .whenComplete(() {
                            Navigator.pop(context);
                            Provider.of<LandingServices>(context, listen: false)
                                .showUserImage(context);
                          });
                        }),
                    MaterialButton(
                        color: brownColor,
                        child: const Text(
                          'Camera',
                          style: TextStyle(
                              color: whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        onPressed: () {
                          pickUserImage(context, ImageSource.camera)
                              .whenComplete(() {
                            Navigator.pop(context);
                            Provider.of<LandingServices>(context, listen: false)
                                .showUserImage(context);
                          });
                        }),
                  ],
                )
              ],
            ),
          );
        });
  }
}
