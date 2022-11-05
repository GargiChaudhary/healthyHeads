import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthy_heads/colors.dart';
import 'package:healthy_heads/services/authentication.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../services/firebase_operations.dart';

class UploadPost with ChangeNotifier {
  TextEditingController captionController = TextEditingController();

  late File uploadPostImage;
  File get getUploadPostImage => uploadPostImage;
  String? uploadPostImageurl;
  String? get getUserAvtarUrl => uploadPostImageurl;
  final picker = ImagePicker();
  late UploadTask imagePostUploadTask;

  Future pickuploadPostImage(BuildContext context, ImageSource source) async {
    final uploadPostImageVal = await picker.pickImage(source: source);

    uploadPostImageVal == null
        ? print('Select Image')
        : uploadPostImage = File(uploadPostImageVal.path);
    print(uploadPostImage.path);

    uploadPostImage != null
        ? showPostImage(context)
        : print('Image Upload Error !!!');

    notifyListeners();
  }

  selectPostImageType(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: darkGreyColor, borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 150.0),
                  child: Divider(
                    thickness: 3.0,
                    color: whiteColor,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        pickuploadPostImage(context, ImageSource.gallery);
                      },
                      color: darkBlueColor,
                      child: const Text(
                        "Gallery",
                        style: TextStyle(
                            color: whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        pickuploadPostImage(context, ImageSource.camera);
                      },
                      color: darkBlueColor,
                      child: const Text(
                        "Camera",
                        style: TextStyle(
                            color: whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }

  showPostImage(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: blackColor, borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 150.0),
                  child: Divider(
                    thickness: 4.0,
                    color: whiteColor,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                  child: Container(
                    height: 200.0,
                    width: 400.0,
                    child: Image.file(
                      uploadPostImage,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
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
                            selectPostImageType(context);
                          }),
                      MaterialButton(
                          color: darkBlueColor,
                          child: const Text(
                            'Confirm Image',
                            style: TextStyle(
                              color: whiteColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            uploadPostImageToFirebase().whenComplete(() {
                              editPostSheet(context);
                              print("Image uploaded successfully !!! ");
                            });
                          })
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future uploadPostImageToFirebase() async {
    Reference imageReference = FirebaseStorage.instance
        .ref()
        .child('posts/${uploadPostImage.path}/${TimeOfDay.now()}');
    imagePostUploadTask = imageReference.putFile(uploadPostImage);
    await imagePostUploadTask.whenComplete(() {
      print("Image uploaded to the firebase storage");
    });
    imageReference.getDownloadURL().then((imageUrl) {
      uploadPostImageurl = imageUrl;
      print(uploadPostImageurl);
    });
    notifyListeners();
  }

  editPostSheet(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width,
            color: darkGreyColor,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 150.0),
                  child: Divider(
                    thickness: 3.0,
                    color: whiteColor,
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.image_aspect_ratio,
                                  color: Colors.green,
                                )),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.fit_screen,
                                  color: Colors.yellow,
                                )),
                          ],
                        ),
                      ),
                      Container(
                        height: 200,
                        width: 300,
                        child: Image.file(
                          uploadPostImage,
                          fit: BoxFit.contain,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      const SizedBox(
                        height: 30,
                        width: 30,
                        child: Icon(
                          Icons.message,
                          color: whiteColor,
                        ),
                      ),
                      Container(
                        height: 110,
                        width: 5,
                        color: darkBlueColor,
                      ),
                      Container(
                        height: 120,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            maxLines: 15,
                            textCapitalization: TextCapitalization.words,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(300)
                            ],
                            controller: captionController,
                            style: const TextStyle(
                                color: whiteColor,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                            decoration: const InputDecoration(
                                hintText: "Add a Caption ....",
                                hintStyle: TextStyle(
                                    color: whiteColor,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                MaterialButton(
                  onPressed: () async {
                    Provider.of<FirebaseOperations>(context, listen: false)
                        .uploadPostData(captionController.text, {
                      'caption': captionController.text,
                      'username': Provider.of<FirebaseOperations>(context,
                              listen: false)
                          .initUserName,
                      'userimage': Provider.of<FirebaseOperations>(context,
                              listen: false)
                          .initUserImage,
                      'useruid':
                          Provider.of<Authentication>(context, listen: false)
                              .getUserUid,
                      'time': Timestamp.now(),
                      'useremail': Provider.of<FirebaseOperations>(context,
                              listen: false)
                          .initUserEmail,
                      'postimage': getUserAvtarUrl
                    }).whenComplete(() {
                      Navigator.pop(context);
                    });
                  },
                  child: const Text(
                    "Share",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: whiteColor),
                  ),
                  color: darkBlueColor,
                )
              ],
            ),
          );
        });
  }
}
