import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:garage/Screens/details/components/details_screen.dart';
import 'package:garage/Screens/login/login.dart';
import 'package:garage/components/home_components/countdown_painter.dart';
import 'package:garage/components/home_components/task_card.dart';
import 'package:garage/constants.dart';
import 'package:garage/models/task.dart';
import 'package:garage/models/user_class.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

import 'package:garage/components/home_components/recent_tasks.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
    getEmployeeList();
    // print(vehiclesList);
  }

  @override
  Widget build(BuildContext context) {
    RefreshController _refreshController =
        RefreshController(initialRefresh: false);

    void _onRefresh() async {
      // monitor network fetch
      getVehicleList();
      await Future.delayed(Duration(milliseconds: 1000));
      // if failed,use refreshFailed()

      _refreshController.refreshCompleted();
    }

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
                SmartRefresher(
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  child: ListView.builder(
                    itemCount: vehiclesList.length, //recentTasks.length,
                    key: Key("${Random().nextDouble()}"),
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
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }

  Future getEmployeeList() async {
    var data = await FirebaseFirestore.instance
        .collection("users")
        .orderBy("name")
        .get();
    if (this.mounted) {
      setState(() {
        employeeList =
            List.from(data.docs.map((doc) => User.fromSnapshot(doc)));
      });
    }
  }

  Future getVehicleList() async {
    var data = await FirebaseFirestore.instance
        .collection("vehicles")
        .orderBy("time", descending: true)
        .get();
    if (this.mounted) {
      setState(() {
        vehiclesList =
            List.from(data.docs.map((doc) => Task.fromSnapshot(doc)));
      });
    }
  }
}
