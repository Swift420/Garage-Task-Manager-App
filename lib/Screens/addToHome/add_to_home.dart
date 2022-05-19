import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garage/models/task.dart';
import 'package:garage/models/task_class.dart';
import 'package:hive/hive.dart';

class AddToHome extends StatefulWidget {
  //final Task task;
  const AddToHome({
    Key? key,
  }) : super(key: key);

  @override
  State<AddToHome> createState() => _AddToHomeState();
}

class _AddToHomeState extends State<AddToHome> {
  TextEditingController _vehicleController = TextEditingController();
  TextEditingController _ownerController = TextEditingController();
  DateTime now = DateTime.now();
  Task? _task;
  Box box = Hive.box('userBox');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Color(0xFF212121),
        body: Column(
          children: [
            Center(
                child: Text(
              "Add Vehicle To List",
              style: TextStyle(color: Colors.white, fontSize: 26),
            )),
            SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: TextField(
                controller: _vehicleController,
                decoration: InputDecoration(
                    //label: Text("Employee Name"),
                    labelText: "Name Of Vehicle",
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.orange,
                    ))),
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: TextField(
                controller: _ownerController,
                decoration: InputDecoration(
                    //label: Text("Employee Name"),
                    labelText: "Name Of Owner",
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.orange,
                    ))),
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 80,
            ),
            Container(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                    side: BorderSide(width: 3, color: Colors.orange)),
                child: Text("Add Vehicle"),
                onPressed: () async {
                  if (box.get(99) == true) {
                    if (_ownerController.text.isNotEmpty &&
                        _vehicleController.text.isNotEmpty) {
                      _task?.title = _vehicleController.text;
                      _task?.owner = _ownerController.text;
                      _task?.time = now;
                      _task?.assignedTask = [];

                      /*  DocumentReference docRef = await FirebaseFirestore
                          .instance
                          .collection('vehicles')
                          .add({
                        'title': _vehicleController.text,
                        'owner': _ownerController.text,
                        'time': now,
                        'assignedTask': [],
                      });
                      String id = docRef.id;

                      await FirebaseFirestore.instance
                          .collection('vehicles')
                          .doc(id)
                          .update({'id': id}); */

                      FirebaseFirestore.instance
                          .collection("vehicles")
                          .doc(_vehicleController.text)
                          .set({
                        'title': _vehicleController.text,
                        'owner': _ownerController.text,
                        'time': now,
                        'assignedTask': [],
                      });

                      /* await FirebaseFirestore.instance
                        .collection("vehicles")
                        .add({
                      'title': _vehicleController.text,
                      'owner': _ownerController.text,
                      'time': now,
                      'assignedTask': [
                        {
                          "name": "John",
                          "taskType": "Mechinical",
                          "employeeTask": "Gear Box",
                          "isComplete": true,
                          "vehicle": "18 Wheeler",
                        },
                        {
                          "name": "Jake",
                          "taskType": "Electro",
                          "employeeTask": "Gear Box",
                          "isComplete": true,
                          "vehicle": "Semi Truck",
                        },
                      ],
                    }); */
                    }
                    setState(() {
                      /* recentTasks.insert(
                        0,
                        Task(
                            title: _vehicleController.text,
                            owner: _ownerController.text,
                            time: now,
                            assignedTask: []) 
                            
                            );  */

                      _ownerController.text = "";
                      _vehicleController.text = "";
                    });
                  } else {
                    showVehicleToast();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showVehicleToast() => Fluttertoast.showToast(msg: "Only admin can add");
}
