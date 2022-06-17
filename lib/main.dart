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

  if (box.get("Kenobi") == null) {
    box.put("Kenobi",
        HiveUser(username: "Kenobi", password: "goat", isAdmin: true));
  }
  if (box.get("Anakin") == null) {
    box.put("Anakin",
        HiveUser(username: "Anakin", password: "sand", isAdmin: true));
  }
  if (box.get("Ahsoka") == null) {
    box.put("Ahsoka",
        HiveUser(username: "Ahsoka", password: "snips", isAdmin: false));
  }
  if (box.get("Maul") == null) {
    box.put(
        "Maul", HiveUser(username: "Maul", password: "fear", isAdmin: false));
  }
  if (box.get("Padme") == null) {
    box.put(
        "Padme", HiveUser(username: "Padme", password: "luke", isAdmin: false));
  }

  if (box.get("Palpetine") == null) {
    box.put("Palpetine",
        HiveUser(username: "Palpetine", password: "treason", isAdmin: false));
  }
  if (box.get("Rex") == null) {
    box.put(
        "Rex", HiveUser(username: "Rex", password: "soldier", isAdmin: false));
  }

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
