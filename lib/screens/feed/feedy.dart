import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:healthy_heads/colors.dart';
import 'package:provider/provider.dart';

import '../../utils/upload_post.dart';

class FeedHelpers with ChangeNotifier {
  Widget feedBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              color: blackColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18.0),
                  topRight: Radius.circular(18.0))),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('posts').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: SizedBox(
                    height: 500.0,
                    width: 400.0,
                    child: Center(
                        child: Text(
                      "Loading...",
                      style: TextStyle(color: whiteColor, fontSize: 20),
                    )),
                  ),
                );
              } else {
                return ListView(
                    children: (snapshot.data!)
                        .docs
                        .map((DocumentSnapshot documentSnapshot) {})
                        .toList());
              }
            },
          ),
        ),
      ),
    );
  }

  Widget loadPosts(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    return ListView(
      children: (snapshot.data!).docs.map((DocumentSnapshot documentSnapshot) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.6,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 8),
                child: Row(
                  children: [
                    GestureDetector(
                      child: CircleAvatar(
                          backgroundColor: transparent,
                          radius: 20.0,
                          backgroundImage:
                              NetworkImage(documentSnapshot['userimage'])
                          // NetworkImage(documentSnapshot['userimage']),
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                documentSnapshot['caption'],
                                style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0),
                              ),
                            ),
                            Container(
                                child: RichText(
                              text: TextSpan(
                                  text: documentSnapshot['username'],
                                  style: const TextStyle(
                                      color: brownColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0),
                                  children: const <TextSpan>[
                                    TextSpan(
                                      text: ' , 12 hours ago',
                                      style: TextStyle(
                                          color: brownColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0),
                                    )
                                  ]),
                            )),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(25)),
                  height: MediaQuery.of(context).size.height * 0.40,
                  width: MediaQuery.of(context).size.width,
                  child: FittedBox(
                    child: Image.network(
                      documentSnapshot['postimage'],
                      scale: 2,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 5.0,
                  left: 35,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 80,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            child: const Icon(
                              Icons.heat_pump_rounded,
                              color: Colors.red,
                              size: 22.0,
                            ),
                          ),
                          const Text(
                            '0',
                            style: TextStyle(
                                color: whiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Provider.of<PostOptions>(context)
                                  .showCommentSheet(context, documentSnapshot,
                                      documentSnapshot['caption']);
                            },
                            child: const Icon(
                              Icons.comment,
                              color: whiteColor,
                              size: 22.0,
                            ),
                          ),
                          const Text(
                            '0',
                            style: TextStyle(
                                color: brownColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            child: const Icon(
                              EvaIcons.share,
                              color: Colors.yellow,
                              size: 22.0,
                            ),
                          ),
                          const Text(
                            '0',
                            style: TextStyle(
                                color: whiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          )
                        ],
                      ),
                    ),
                    // const Spacer(),
                    Container(
                      width: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            child: const Icon(
                              EvaIcons.bookmarkOutline,
                              color: Colors.yellow,
                              size: 22.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              //   Provider.of<Authentication>(context, listen: false).getUserUid ==
              //           documentSnapshot['useruid']
              //       ? IconButton(
              //           onPressed: () {},
              //           icon: Icon(
              //             EvaIcons.moreVertical,
              //             color: constantColors.whitecolor,
              //           ))
              //       : Container(
              //           width: 0.0,
              //           height: 0.0,
              //         )
            ],
          ),
        );
      }).toList(),
    );
  }
}
