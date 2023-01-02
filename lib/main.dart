import 'package:demo_instagram/responsive/mobile_screen_layout.dart';
import 'package:demo_instagram/responsive/responsive_layout_screen.dart';
import 'package:demo_instagram/responsive/web_screen_layout.dart';
import 'package:demo_instagram/screens/login_screen.dart';
import 'package:demo_instagram/screens/signup_screen.dart';
import 'package:demo_instagram/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


//bool shouldUseFirebaseEmulator = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCkotb-6C90saNber_QyDd6zBhFn93W_kg",
          appId: "1:1005315272939:web:f9e2b1f613716b01ea4eae",
          messagingSenderId: "1005315272939",
          projectId: "fir-instagram-f7869",
          storageBucket: "fir-instagram-f7869.appspot.com"),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demo Instagram',
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      // home: ResponsiveLayout(
      //     webScreenLayout: WebScreenLayout(),
      //     mobileScreenLayout: MobileScreenLayout()),
      home: SignUpScreen(),
    );
  }
}
