class AssignedTask {
  String? name;
  String? taskType;
  String? employeeTask;
  bool? isComplete;
  String? vehicle;

  AssignedTask(
      {required this.name,
      required this.taskType,
      required this.employeeTask,
      required this.isComplete,
      required this.vehicle});

  AssignedTask.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    taskType = json['taskType'];
    employeeTask = json['employeeTask'];
    isComplete = json['isComplete'];
    vehicle = json['vehicle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['taskType'] = this.taskType;
    data['employeeTask'] = this.employeeTask;
    data['isComplete'] = this.isComplete;
    data['vehicle'] = this.vehicle;
    return data;
  }

  AssignedTask.fromMap(Map<String, dynamic> taskMap)
      : name = taskMap["title"],
        taskType = taskMap["owner"],
        employeeTask = taskMap["time"],
        isComplete = taskMap["isComplete"],
        vehicle = taskMap["vehicle"];
}
