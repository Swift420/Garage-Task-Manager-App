import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:garage/constants.dart';
import 'package:garage/main.dart';
import 'package:garage/models/user_class.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class EmployeeDetail extends StatefulWidget {
  final User user;
  const EmployeeDetail({Key? key, required this.user}) : super(key: key);

  @override
  State<EmployeeDetail> createState() => _EmployeeDetailState();
}

class _EmployeeDetailState extends State<EmployeeDetail> {
  bool isChecked = false;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    getEmployeeList();
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()

    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    void didChangeDependencies() {
      // TODO: implement didChangeDependencies
      super.didChangeDependencies();

      getEmployeeList();
      // print(vehiclesList);
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.only(left: 100.0),
          child: Text("Tasks"),
        ),
      ),
      backgroundColor: Color(0xFF212121), //0xFF212121
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
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
                      itemCount: widget.user.userTasks!.length,
                      itemBuilder: ((context, index) => EmployeeTile(
                            user: widget.user,
                            count: index,
                          ))),
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
}

class EmployeeTile extends StatefulWidget {
  final User user;
  final int count;
  const EmployeeTile({Key? key, required this.user, required this.count})
      : super(key: key);

  @override
  State<EmployeeTile> createState() => _EmployeeTileState();
}

class _EmployeeTileState extends State<EmployeeTile> {
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    getEmployeeList();
    // print(vehiclesList);
  }

  @override
  Widget build(BuildContext context) {
    bool isChecked = false;
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20, top: 50),
        child: Container(
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(
                      width: 3.0,
                      color: widget.user.userTasks![widget.count].isComplete ==
                              true
                          ? Colors.green[600]!
                          : Colors.orange),
                  left: BorderSide(
                      width: 3.0,
                      color: widget.user.userTasks![widget.count].isComplete ==
                              true
                          ? Colors.green[600]!
                          : Colors.orange),
                  right: BorderSide(
                      width: 3.0,
                      color: widget.user.userTasks![widget.count].isComplete ==
                              true
                          ? Colors.green[600]!
                          : Colors.orange),
                  bottom: BorderSide(
                      width: 3.0,
                      color: widget.user.userTasks![widget.count].isComplete ==
                              true
                          ? Colors.green[600]!
                          : Colors.orange))),
          child: InkWell(
            child: CheckboxListTile(
                side: BorderSide(
                  color: Colors.orange,
                ),
                tileColor: Colors.white10,
                checkColor: Colors.white,
                activeColor: Colors.green,
                title: Text(
                  "${widget.user.userTasks![widget.count].employeeTask}",
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  "${widget.user.userTasks![widget.count].vehicle} - ${widget.user.userTasks![widget.count].taskType}",
                  style: TextStyle(color: Colors.white),
                ),
                value: widget.user.userTasks![widget.count].isComplete!,
                onChanged: (value) {
                  setState(() {
                    if (box.get(99) == widget.user.name &&
                        widget.user.userTasks![widget.count].isComplete ==
                            true) {
                      FirebaseFirestore.instance
                          .collection("users")
                          .doc(widget.user.name)
                          .update({
                        "userTasks": FieldValue.arrayUnion([
                          {
                            "name": widget.user.userTasks![widget.count].name,
                            "taskType":
                                widget.user.userTasks![widget.count].taskType,
                            "employeeTask": widget
                                .user.userTasks![widget.count].employeeTask,
                            "isComplete": false,
                            "vehicle":
                                widget.user.userTasks![widget.count].vehicle
                          }
                        ])
                      });
                      FirebaseFirestore.instance
                          .collection("users")
                          .doc(widget.user.name)
                          .update({
                        "userTasks": FieldValue.arrayRemove([
                          {
                            "name": widget.user.userTasks![widget.count].name,
                            "taskType":
                                widget.user.userTasks![widget.count].taskType,
                            "employeeTask": widget
                                .user.userTasks![widget.count].employeeTask,
                            "isComplete": true,
                            "vehicle":
                                widget.user.userTasks![widget.count].vehicle
                          }
                        ])
                      });

                      FirebaseFirestore.instance
                          .collection("vehicles")
                          .doc(widget.user.name)
                          .update({
                        "userTasks": FieldValue.arrayUnion([
                          {
                            "name": widget.user.userTasks![widget.count].name,
                            "taskType":
                                widget.user.userTasks![widget.count].taskType,
                            "employeeTask": widget
                                .user.userTasks![widget.count].employeeTask,
                            "isComplete": false,
                            "vehicle":
                                widget.user.userTasks![widget.count].vehicle
                          }
                        ])
                      });
                      FirebaseFirestore.instance
                          .collection("vehicles")
                          .doc(widget.user.name)
                          .update({
                        "userTasks": FieldValue.arrayRemove([
                          {
                            "name": widget.user.userTasks![widget.count].name,
                            "taskType":
                                widget.user.userTasks![widget.count].taskType,
                            "employeeTask": widget
                                .user.userTasks![widget.count].employeeTask,
                            "isComplete": true,
                            "vehicle":
                                widget.user.userTasks![widget.count].vehicle
                          }
                        ])
                      });
                    }
                    if (box.get(98) == widget.user.name) {
                      widget.user.userTasks![widget.count].isComplete = value;

                      FirebaseFirestore.instance
                          .collection("users")
                          .doc(widget.user.name)
                          .update({
                        "userTasks": FieldValue.arrayRemove([
                          {
                            "name": widget.user.userTasks![widget.count].name,
                            "taskType":
                                widget.user.userTasks![widget.count].taskType,
                            "employeeTask": widget
                                .user.userTasks![widget.count].employeeTask,
                            "isComplete": false,
                            "vehicle":
                                widget.user.userTasks![widget.count].vehicle
                          }
                        ])
                      });

                      FirebaseFirestore.instance
                          .collection("users")
                          .doc(widget.user.name)
                          .update({
                        "userTasks": FieldValue.arrayUnion([
                          {
                            "name": widget.user.userTasks![widget.count].name,
                            "taskType":
                                widget.user.userTasks![widget.count].taskType,
                            "employeeTask": widget
                                .user.userTasks![widget.count].employeeTask,
                            "isComplete": true,
                            "vehicle":
                                widget.user.userTasks![widget.count].vehicle
                          }
                        ])
                      });
                      print(widget.user.userTasks![widget.count].vehicle);

                      FirebaseFirestore.instance
                          .collection("vehicles")
                          .doc(widget.user.userTasks![widget.count].vehicle)
                          .update({
                        "assignedTask": FieldValue.arrayRemove([
                          {
                            "name": widget.user.userTasks![widget.count].name,
                            "taskType":
                                widget.user.userTasks![widget.count].taskType,
                            "employeeTask": widget
                                .user.userTasks![widget.count].employeeTask,
                            "isComplete": false,
                            "vehicle":
                                widget.user.userTasks![widget.count].vehicle
                          }
                        ])
                      });

                      FirebaseFirestore.instance
                          .collection("vehicles")
                          .doc(widget.user.userTasks![widget.count].vehicle)
                          .update({
                        "assignedTask": FieldValue.arrayUnion([
                          {
                            "name": widget.user.userTasks![widget.count].name,
                            "taskType":
                                widget.user.userTasks![widget.count].taskType,
                            "employeeTask": widget
                                .user.userTasks![widget.count].employeeTask,
                            "isComplete": true,
                            "vehicle":
                                widget.user.userTasks![widget.count].vehicle
                          }
                        ])
                      });
                    }
                  });
                }),
            onTap: () {},
          ),
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
}
