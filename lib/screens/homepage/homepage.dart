import 'package:flutter/material.dart';
import 'package:healthy_heads/colors.dart';
import 'package:provider/provider.dart';
import '../../services/firebase_operations.dart';
import '../chatroom/chatbot.dart';
import '../feed/feed.dart';
import '../profile/profile.dart';
import 'homepage_helpers.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController homePageController = PageController();
  int pageIndex = 0;

  @override
  void initState() {
    Provider.of<FirebaseOperations>(context, listen: false)
        .initUserData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      body: PageView(
        controller: homePageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (page) {
          setState(() {
            pageIndex = page;
          });
        },
        children: const [Feed(), ChatBot(), Profile()],
      ),
      bottomNavigationBar: Provider.of<HomepageHelpers>(context, listen: false)
          .bottomNavBar(context, pageIndex, homePageController),
    );
  }
}
