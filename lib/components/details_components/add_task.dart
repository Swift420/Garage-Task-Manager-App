import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:garage/constants.dart';
import 'package:garage/main.dart';
import 'package:garage/models/task.dart';
import 'package:garage/models/task_class.dart';

class addTask extends StatefulWidget {
  final Task task;
  const addTask({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  State<addTask> createState() => _addTaskState();
}

class _addTaskState extends State<addTask> {
  List<String> employees = ["Maul", "Padme", "Palpetine", "Rex", "Ahsoka"];
  String? selectedItem = "Maul";
  List<String> taskTypesList = ["Mechanical", "Electronical", "Trailer"];
  String? selectedTask = "Mechanical";
  TextEditingController _briefController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            children: [
              Text(
                "Add New Task",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.cancel, color: Colors.orange, size: 25),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: TextFormField(
            controller: _briefController,
            decoration: InputDecoration(
              //label: Text("Employee Name"),
              labelText: "Brief Desc of task",
              labelStyle: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
              border: InputBorder.none,
              fillColor: kCardColor,
              filled: true,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          width: 250,
          child: DropdownButtonFormField<String>(
              dropdownColor: kCardColor,
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                  label: Text(
                    "Task Type",
                    style: TextStyle(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(width: 3, color: Colors.orange))),
              value: selectedTask,
              items: taskTypesList
                  .map((task) => DropdownMenuItem<String>(
                        value: task,
                        child: Text(task),
                      ))
                  .toList(),
              onChanged: (task) => setState(() {
                    selectedTask = task;
                  })),
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          width: 250,
          child: DropdownButtonFormField<String>(
              dropdownColor: kCardColor,
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                  label: Text(
                    "Employee",
                    style: TextStyle(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(width: 3, color: Colors.orange))),
              value: selectedItem,
              items: employees
                  .map((employee) => DropdownMenuItem<String>(
                        value: employee,
                        child: Text(employee),
                      ))
                  .toList(),
              onChanged: (employee) => setState(() {
                    selectedItem = employee;
                  })),
        ),
        SizedBox(height: 20),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          width: 150,
          child: Container(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  side: BorderSide(width: 3, color: Colors.orange)),
              child: Text("Add Task"),
              onPressed: () {
                print(widget.task.id);

                setState(() {
                  FirebaseFirestore.instance
                      .collection("vehicles")
                      .doc(widget.task.title)
                      .update({
                    "assignedTask": FieldValue.arrayUnion([
                      {
                        "name": selectedItem!,
                        "taskType": selectedTask!,
                        "employeeTask": _briefController.text,
                        "isComplete": false,
                        "vehicle": widget.task.title!
                      }
                    ])
                  });

                  FirebaseFirestore.instance
                      .collection("users")
                      .doc(selectedItem!)
                      .update({
                    "userTasks": FieldValue.arrayUnion([
                      {
                        "name": selectedItem!,
                        "taskType": selectedTask!,
                        "employeeTask": _briefController.text,
                        "isComplete": false,
                        "vehicle": widget.task.title!
                      }
                    ])
                  });

                  /*widget.task.assignedTask!.add(AssignedTask(
                      name: selectedItem!,
                      taskType: selectedTask!,
                      employeeTask: _briefController.text,
                      isComplete: false,
                      vehicle: widget.task.title!)); */
                });
                Navigator.of(context).pop();
              },
            ),
          ),
        )
      ],
    );
  }
}
