import 'dart:convert';

import 'package:garage/models/task_class.dart';
import 'package:garage/models/task_class.dart';

import 'task_class.dart';

class Task {
  String? title;
  String? owner;
  String? id;
  DateTime? time;

  List<AssignedTask>? assignedTask;

  Task(
      {required this.title,
      required this.owner,
      required this.time,
      required this.assignedTask,
      required this.id});

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'owner': owner,
      'time': time,
      "id": id,
      'assignedTask': assignedTask?.map((a) => a.toJson()).toList(),
    };
  }

  Task.fromSnapshot(snapshot) {
    title = snapshot.data()["title"];
    owner = snapshot.data()["owner"];
    id = snapshot.data()["id"];
    time = snapshot.data()["time"].toDate();
    if (snapshot.data()["assignedTask"] != null) {
      assignedTask = <AssignedTask>[];
      snapshot.data()['assignedTask'].forEach((v) {
        assignedTask?.add(AssignedTask.fromJson(v));
      });
    }
  } //snapshot.data()["assignedTask"] as List<AssignedTask.fromJson(json)>;

  /* List<AssignedTask>.from(snapshot.data()["assignedTask"].map((item) {
          AssignedTask(
              name: item["name"],
              taskType: item["taskType"],
              employeeTask: item["employeeTask"],
              isComplete: item["isComplete"],
              vehicle: item["vehicle"]);
        })); */
  //json.decode(snapshot.data()["assignedTask"]);
  //Map<String, AssignedTask>.from(json.decode(snapshot.data()["assignedTask"]));
  //json.decode(snapshot.data()["assignedTask"]).cast<AssignedTask>();

  //  snapshot.data()["assignedTask"].cast<List<AssignedTask>>();
  //AssignedTask.f(snapshot.data()!["assignedTask"]),
  //  snapshot.data()["assignedTask"].cast<AssignedTask>();
  //List<AssignedTask>.from((json.decode(['assignedTask'])).map((x) => AssignedTask.fromJson(x))

/*
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
  } */
  Task.fromJson(Map<String, dynamic> json) {
    owner = json['owner'];
    if (json['assignedTask'] != null) {
      // ignore: deprecated_member_use
      assignedTask = <AssignedTask>[];
      json['assignedTask'].forEach((v) {
        assignedTask!.add(new AssignedTask.fromJson(v));
      });
    }
    time = json['time'];
    title = json['title'];
  }
  Task.fromMap(Map<String, dynamic> taskMap)
      : title = taskMap["title"],
        owner = taskMap["owner"],
        time = taskMap["time"],
        assignedTask = taskMap["assignedTask"];
}

List<Task> recentTasks = [];
List<Task> vehiclesList = [];
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