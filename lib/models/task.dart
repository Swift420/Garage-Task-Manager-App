import 'dart:convert';

import 'package:garage/models/task_class.dart';

class Task {
  String? title;
  String? owner;
  DateTime? time;

  List<AssignedTask>? assignedTask;

  Task(
      {required this.title,
      required this.owner,
      required this.time,
      required this.assignedTask});

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'owner': owner,
      'time': time,
      'assignedTask': assignedTask?.map((a) => a.toJson()).toList(),
    };
  }
  /*
  Task.fromSnapshot(snapshot)
      : title = snapshot.data()["title"],
        owner = snapshot.data()["owner"],
        time = snapshot.data()["time"].toDate(),
        assignedTask = List<AssignedTask>.from((json.decode(['assignedTask'])).map((x) => AssignedTask.fromJson(x)))
        */

  Task.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    owner = json['owner'];
    time = json['time'];
    if (json['assignedTask'] != null) {
      assignedTask = <AssignedTask>[];
      json['assignedTask'].forEach((v) {
        assignedTask!.add(new AssignedTask.fromJson(v));
      });
    }
  }

  Task.fromMap(Map<String, dynamic> taskMap)
      : title = taskMap["title"],
        owner = taskMap["owner"],
        time = taskMap["time"],
        assignedTask = taskMap["assignedTask"];
}

List<Task> recentTasks = [];

/*
List<Task> recentTasks = [
  Task(
    title: "18 Wheeler",
    owner: "Darth Vader",
    time: DateTime.parse("2020-06-06 12:30:00"),
    assignedTask: [
      AssignedTask(
          name: "John",
          taskType: "Mechinical",
          employeeTask: "Gear Box",
          isComplete: true,
          vehicle: "18 Wheeler"),
      AssignedTask(
          name: "Palpetine",
          taskType: "Trailer",
          employeeTask: "Faulty Steering System and Suspension",
          isComplete: false,
          vehicle: "18 Wheeler"),
      AssignedTask(
          name: "Windu",
          taskType: "Electronical",
          employeeTask: "Malfunctioning Wipers",
          isComplete: true,
          vehicle: "18 Wheeler"),
      AssignedTask(
          name: "Rex",
          taskType: "Mechinical",
          employeeTask: "Faulty Brakes",
          isComplete: false,
          vehicle: "18 Wheeler"),
    ],
  ),
  Task(
    title: "Semi Trailer",
    owner: "Obi wan",
    time: DateTime.parse("2020-06-06 14:30:00"),
    assignedTask: [
      AssignedTask(
          name: "Jane",
          taskType: "Mechinical",
          employeeTask: "Gear Bpx",
          isComplete: false,
          vehicle: "18 Wheeler")
    ],
  ),
  Task(
    title: "Semi Trailer",
    owner: "General Grevious",
    time: DateTime.parse("2020-06-06 14:30:00"),
    assignedTask: [
      AssignedTask(
          name: "Kim",
          taskType: "Mechinical",
          employeeTask: "Gear Bpx",
          isComplete: false,
          vehicle: "Semi Trailer")
    ],
  ),
  Task(
    title: "Semi Trailer",
    owner: "Padme",
    time: DateTime.parse("2020-06-06 14:30:00"),
    assignedTask: [
      AssignedTask(
          name: "John",
          taskType: "Mechinical",
          employeeTask: "Gear Bpx",
          isComplete: false,
          vehicle: "Semi Trailer")
    ],
  ),
  Task(
    title: "Semi Trailer",
    owner: "Yoda",
    time: DateTime.parse("2020-06-06 14:30:00"),
    assignedTask: [
      AssignedTask(
          name: "Max",
          taskType: "Mechinical",
          employeeTask: "Gear Bpx",
          isComplete: false,
          vehicle: "Semi Trailer")
    ],
  ),
  Task(
    title: "Semi Trailer",
    owner: "Master Skywalker",
    time: DateTime.parse("2020-06-06 14:30:00"),
    assignedTask: [],
  ),
];
*/