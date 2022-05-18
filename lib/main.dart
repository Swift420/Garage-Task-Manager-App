import 'package:flutter/material.dart';
import 'package:garage/Screens/Navigation/bottom_nav.dart';
import 'package:garage/Screens/home/home.dart';
import 'package:garage/Screens/login/login.dart';
import 'package:garage/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'Flutter Animated Login',
        debugShowCheckedModeBanner: false,
        /* theme: ThemeData(
          primaryColor: kPrimaryColor,
          textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme)),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        // textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
        /* dark theme settings */
      ), */
        //themeMode: ThemeMode.dark,
        home: LoginPage(title: '') // BottomNav(),
        );
  }
}
