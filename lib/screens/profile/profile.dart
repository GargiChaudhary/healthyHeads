import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:healthy_heads/colors.dart';
import 'package:healthy_heads/screens/profile/profile_helpers.dart';
import 'package:provider/provider.dart';

import '../../services/authentication.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkGreyColor,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(EvaIcons.settings2Outline, color: brownColor),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<ProfileHelpers>(context, listen: false)
                  .logOutDialog(context);
            },
            icon: const Icon(EvaIcons.logOutOutline, color: Colors.green),
          )
        ],
        backgroundColor: darkGreyColor.withOpacity(0.4),
        title: RichText(
          text: const TextSpan(
              text: 'My ',
              style: TextStyle(
                  color: whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: 'Poppins'),
              children: <TextSpan>[
                TextSpan(
                  text: 'Profile',
                  style: TextStyle(
                      color: brownColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'Poppins'),
                )
              ]),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(15),
              color: darkGreyColor.withOpacity(0.6)),
          child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(Provider.of<Authentication>(context, listen: false)
                    .getUserUid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Column(
                  children: [
                    Provider.of<ProfileHelpers>(context, listen: false)
                        .headerProfile(context, snapshot),
                    Provider.of<ProfileHelpers>(context, listen: false)
                        .divider(),
                    Provider.of<ProfileHelpers>(context, listen: false)
                        .middleProfile(context, snapshot),
                    Provider.of<ProfileHelpers>(context, listen: false)
                        .footerProfile(context, snapshot),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
