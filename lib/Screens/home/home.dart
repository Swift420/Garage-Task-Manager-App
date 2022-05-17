import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:garage/Screens/details/components/details_screen.dart';
import 'package:garage/Screens/login/login.dart';
import 'package:garage/components/home_components/countdown_painter.dart';
import 'package:garage/components/home_components/task_card.dart';
import 'package:garage/constants.dart';
import 'package:garage/models/task.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:garage/components/home_components/recent_tasks.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    getVehicleList();
    // print(vehiclesList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF212121), //0xFF212121
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: kDefaultPadding / 2),
            Expanded(
                child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF212121),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                    ),
                  ),
                ),
                ListView.builder(
                  itemCount: vehiclesList.length, //recentTasks.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(
                            task: vehiclesList[index],
                          ),
                        ),
                      );
                    },
                    child: TaskCard(
                      itemIndex: index,
                      task: vehiclesList[index],
                    ),
                  ),
                ),
                //TaskCard(),
              ],
            )),
          ],
        ),
      ),
    );
  }

  Future getVehicleList() async {
    var data = await FirebaseFirestore.instance
        .collection("vehicles")
        .orderBy("time", descending: true)
        .get();

    setState(() {
      vehiclesList = List.from(data.docs.map((doc) => Task.fromSnapshot(doc)));
    });
  }
}
