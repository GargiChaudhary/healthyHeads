import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:healthy_heads/screens/feed/feedy.dart';
import 'package:healthy_heads/screens/homepage/homepage_helpers.dart';
import 'package:healthy_heads/screens/landing/landing_helpers.dart';
import 'package:healthy_heads/screens/landing/landing_services.dart';
import 'package:healthy_heads/screens/landing/landing_utils.dart';
import 'package:healthy_heads/screens/profile/profile_helpers.dart';
import 'package:healthy_heads/screens/splash_screen.dart';
import 'package:healthy_heads/services/authentication.dart';
import 'package:healthy_heads/services/firebase_operations.dart';
import 'package:healthy_heads/utils/upload_post.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Authentication()),
        ChangeNotifierProvider(create: (_) => LandingHelpers()),
        ChangeNotifierProvider(create: (_) => LandingServices()),
        ChangeNotifierProvider(create: (_) => LandingUtils()),
        ChangeNotifierProvider(create: (_) => FirebaseOperations()),
        ChangeNotifierProvider(create: (_) => HomepageHelpers()),
        ChangeNotifierProvider(create: (_) => FeedHelpers()),
        ChangeNotifierProvider(create: (_) => ProfileHelpers()),
        ChangeNotifierProvider(create: (_) => UploadPost()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        theme: ThemeData(fontFamily: 'Montserrat'),
      ),
    );
  }
}
