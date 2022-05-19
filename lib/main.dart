import 'package:flutter/material.dart';
import 'package:garage/Screens/Navigation/bottom_nav.dart';
import 'package:garage/Screens/home/home.dart';
import 'package:garage/Screens/login/login.dart';
import 'package:garage/constants.dart';
import 'package:garage/models/hive_user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';

late Box box;
Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(HiveUserAdapter());
  box = await Hive.openBox('userBox');
  print("this prints first");
  print(box.keys);

  /* box.put(
      "Kenobi", HiveUser(username: "Kenobi", password: "goat", isAdmin: true));

  box.put(
      "Anakin", HiveUser(username: "Anakin", password: "sand", isAdmin: true));
  box.put("Ahsoka",
      HiveUser(username: "Ahsoka", password: "snips", isAdmin: false));
  box.put("Maul", HiveUser(username: "Maul", password: "fear", isAdmin: false));
  box.put(
      "Padme", HiveUser(username: "Padme", password: "luke", isAdmin: false));
  box.put("Palpetine",
      HiveUser(username: "Palpetine", password: "treason", isAdmin: false));
  box.put("Windu",
      HiveUser(username: "Windu", password: "council", isAdmin: false));
  box.put(
      "Rex", HiveUser(username: "Rex", password: "soldier", isAdmin: false));
  box.put("Grievious",
      HiveUser(username: "Grievious", password: "saber", isAdmin: false));
  box.put("Jar Jar",
      HiveUser(username: "Jar Jar", password: "Misa", isAdmin: false));
  box.put("Savage",
      HiveUser(username: "Savage", password: "savage", isAdmin: false));
  box.put("Jango",
      HiveUser(username: "Jango", password: "headless", isAdmin: false));
  box.put(
      "Boba", HiveUser(username: "Boba", password: "father", isAdmin: false));
  box.put(
      "Dooku", HiveUser(username: "Dooku", password: "count", isAdmin: false));
  box.put("Bane",
      HiveUser(username: "Bane", password: "sharpshooter", isAdmin: false)); */
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
      home: LoginPage(title: ''), //BottomNav(),
    );
  }
}
