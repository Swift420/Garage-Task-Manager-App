import 'package:flutter/material.dart';
import 'package:garage/models/task_class.dart';

class User {
  String name;
  bool isAdmin = false;
  List<AssignedTask> userTasks;

  User({required this.name, required this.isAdmin, required this.userTasks});
}

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
