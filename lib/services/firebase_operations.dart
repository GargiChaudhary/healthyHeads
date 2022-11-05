// import 'dart:js';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/landing/landing_utils.dart';
import 'authentication.dart';

class FirebaseOperations with ChangeNotifier {
  UploadTask? imageUploadTask;
  String? initUserEmail, initUserImage, initUserName;
  String? get getInitUserEmail => initUserEmail;
  String? get getInitUserName => initUserName;
  String? get getInitUserImage => initUserImage;

  Future uploadUserImage(BuildContext context) async {
    Reference imageReference = FirebaseStorage.instance.ref().child(
        'userProfileImage/${Provider.of<LandingUtils>(context, listen: false).getUserImage.path}/${TimeOfDay.now()}');

    imageUploadTask = imageReference.putFile(
        Provider.of<LandingUtils>(context, listen: false).getUserImage);
    await imageUploadTask?.whenComplete(() {
      // print('Image uploaded!');
    });

    imageReference.getDownloadURL().then((url) {
      Provider.of<LandingUtils>(context, listen: false).userImageUrl =
          url.toString();
      // print('The user profile image url => ${Provider.of<LandingUtils>(context, listen: false).userImageUrl}');
      notifyListeners();
    });
  }

  Future createUserCollection(BuildContext context, dynamic data) async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(Provider.of<Authentication>(context, listen: false).getUserUid)
        .set(data);
  }

  Future uploadPostData(String postId, dynamic data) async {
    return FirebaseFirestore.instance.collection('posts').doc(postId).set(data);
  }

  Future initUserData(BuildContext context) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(Provider.of<Authentication>(context, listen: false).getUserUid)
        .get()
        .then((doc) {
      print('Fetching user data');
      initUserName = doc['username'];
      initUserImage = doc['userimage'];
      initUserEmail = doc['useremail'];
      notifyListeners();
      print(initUserName);
      print(initUserEmail);
      print(initUserImage);
    });
  }
}
