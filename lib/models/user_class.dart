import 'package:flutter/material.dart';
import 'package:garage/models/task_class.dart';

class User {
  String? name;

  bool? isAdmin = false;

  List<AssignedTask>? userTasks;

  User({
    required this.name,
    required this.isAdmin,
    required this.userTasks,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'isAdmin': isAdmin,
      'userTasks': userTasks?.map((a) => a.toJson()).toList(),
    };
  }

  User.fromSnapshot(snapshot) {
    name = snapshot.data()["name"];
    isAdmin = snapshot.data()["isAdmin"];
    if (snapshot.data()["userTasks"] != null) {
      userTasks = <AssignedTask>[];
      snapshot.data()['userTasks'].forEach((v) {
        userTasks?.add(AssignedTask.fromJson(v));
      });
    }
  }
}

List<User> employeeList = [];

List<User> users = [
  User(name: "John", isAdmin: false, userTasks: [
    AssignedTask(
        name: "John",
        taskType: "Mechinical",
        employeeTask: "Gear Bpx",
        isComplete: false,
        vehicle: "Semi Trailer"),
    AssignedTask(
        name: "John",
        taskType: "Mechinical",
        employeeTask: "Gear Bpx",
        isComplete: false,
        vehicle: "Semi Trailer")
  ]),
  User(name: "Palpetine", isAdmin: false, userTasks: [
    AssignedTask(
        name: "Palpetine",
        taskType: "Mechinical",
        employeeTask: "Gear Bpx",
        isComplete: true,
        vehicle: "Semi Trailer"),
    AssignedTask(
        name: "Palpetine",
        taskType: "Electronical",
        employeeTask: "Gear Bpx",
        isComplete: false,
        vehicle: "Semi Trailer")
  ]),
  User(name: "Windu", isAdmin: false, userTasks: []),
  User(name: "Anakin", isAdmin: false, userTasks: []),
  User(name: "Rex", isAdmin: false, userTasks: []),
];
