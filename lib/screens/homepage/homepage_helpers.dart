import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:healthy_heads/colors.dart';
import 'package:provider/provider.dart';

import '../../services/firebase_operations.dart';

class HomepageHelpers with ChangeNotifier {
  Widget bottomNavBar(
      BuildContext context, int index, PageController pageController) {
    return CustomNavigationBar(
      currentIndex: index,
      bubbleCurve: Curves.bounceIn,
      scaleCurve: Curves.decelerate,
      selectedColor: brownColor,
      unSelectedColor: whiteColor,
      strokeColor: brownColor,
      scaleFactor: 0.5,
      iconSize: 30.0,
      onTap: (val) {
        index = val;
        pageController.jumpToPage(val);
        notifyListeners();
      },
      backgroundColor: const Color(0xff040307),
      items: [
        CustomNavigationBarItem(icon: const Icon(EvaIcons.home)),
        CustomNavigationBarItem(icon: const Icon(Icons.message_rounded)),
        CustomNavigationBarItem(
            icon: CircleAvatar(
          radius: 35.0,
          backgroundColor: brownColor,
          backgroundImage: NetworkImage(
              Provider.of<FirebaseOperations>(context, listen: false)
                      .initUserImage ??
                  ''),
        )),
      ],
    );
  }
}
