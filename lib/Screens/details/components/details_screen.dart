import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garage/Screens/home/home.dart';
import 'package:garage/components/details_components/add_task.dart';
import 'package:garage/constants.dart';
import 'package:garage/models/task.dart';
import 'package:garage/models/task_class.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DetailsScreen extends StatefulWidget {
  final Task task;
  const DetailsScreen({Key? key, required this.task}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
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

    int numOfCompletedInspection = widget.task.assignedTask!
        .where((element) => element.isComplete == false)
        .length;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Color(0xFF212121), //0xFF212121
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, bottom: 20),
                  child: Container(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          primary: Colors.orange,
                          side: BorderSide(width: 3, color: Colors.orange)),
                      child: Text("Add New Task"),
                      onPressed: () {
                        setState(() {
                          _addNewTaskModal(context, widget.task);
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, bottom: 20),
                  child: Container(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          primary: Colors.orange,
                          side:
                              BorderSide(width: 3, color: Colors.green[600]!)),
                      child: Text(
                        "Pass Inspection",
                        style: TextStyle(color: Colors.green[600]),
                      ),
                      onPressed: () async {
                        if (numOfCompletedInspection == 0) {
                          passInspection();
                        } else {
                          showToast();
                        }

                        //print(jsonEncode(widget.task.assignedTask));
                        // setState(() {});
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: kDefaultPadding / 2),
            Expanded(
                child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF212121),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SmartRefresher(
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  child: ListView.builder(
                      itemCount: widget.task.assignedTask!.length,
                      itemBuilder: ((context, index) => InkWell(
                            child: ServiceTask(
                              task: widget.task,
                              count: index,
                            ),
                            onLongPress: () {
                              setState(() {
                                widget.task.assignedTask![index].isComplete =
                                    false;
                              });

                              print(
                                  widget.task.assignedTask![index].isComplete);
                            },
                          ))),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }

  void _addNewTaskModal(context, task) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Color(0xFF212121),
        builder: (BuildContext bc) {
          return Container(
            height: MediaQuery.of(context).size.height * .60,
            child: addTask(task: task),
          );
        });
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

  Future passInspection() async {
    DocumentReference docRef =
        await FirebaseFirestore.instance.collection('recentHistory').add({
      'title': widget.task.title,
      'owner': widget.task.owner,
      'time': widget.task.time,
      'assignedTask': widget.task.assignedTask?.map((a) => a.toJson()).toList()
    });
    String id = docRef.id;

    await FirebaseFirestore.instance
        .collection('recentHistory')
        .doc(id)
        .update({'id': id});
  }

  void showToast() => Fluttertoast.showToast(
        msg: "Can only pass inspection if all tasks are green",
        fontSize: 18,
      );
}

class ServiceTask extends StatelessWidget {
  final Task task;
  final int count;
  const ServiceTask({
    Key? key,
    required this.task,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: 10,
      ),
      //color: Colors.blueAccent,

      height: 120,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: task.assignedTask![count].isComplete == true
                    ? Colors.green[600]
                    : Colors.orange),
            child: Container(
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                  color: kCardColor, borderRadius: BorderRadius.circular(22)),
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              child: SizedBox(
                height: 120,
                width: MediaQuery.of(context).size.width - 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Text(
                        "${task.assignedTask![count].taskType}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Text(
                        "${task.assignedTask![count].employeeTask}",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 1.5,
                        vertical: kDefaultPadding / 4,
                      ),
                      decoration: BoxDecoration(
                        color: task.assignedTask![count].isComplete == true
                            ? Colors.green[600]
                            : kSecondaryColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          topRight: Radius.circular(7),
                        ),
                      ),
                      child: Text("${task.assignedTask![count].name}"),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
