import 'package:flutter/material.dart';
import 'package:healthy_heads/colors.dart';
import 'package:provider/provider.dart';
import '../../utils/upload_post.dart';
import 'feedy.dart';

class Feed extends StatelessWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkGreyColor,
      drawer: const Drawer(),
      appBar: AppBar(
          backgroundColor: transparent,
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Provider.of<UploadPost>(context, listen: false)
                      .selectPostImageType(context);
                },
                icon: const Icon(Icons.camera_alt))
          ],
          title: RichText(
            text: const TextSpan(
                text: 'healthy',
                style: TextStyle(
                  color: whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Heads',
                      style: TextStyle(
                          color: brownColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20))
                ]),
          )),
      body: Provider.of<FeedHelpers>(context, listen: false).feedBody(context),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.pushReplacement(
      //         context,
      //         PageTransition(
      //             child: ChatBot(), type: PageTransitionType.bottomToTop));
      //   },
      //   child: Icon(Icons.message_outlined),
      //   backgroundColor: Color.fromARGB(228, 49, 47, 47),
      // )
    );
  }
}
