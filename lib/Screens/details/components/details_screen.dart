import 'package:flutter/material.dart';
import 'package:garage/components/details_components/add_task.dart';
import 'package:garage/constants.dart';
import 'package:garage/models/task.dart';
import 'package:garage/models/task_class.dart';

class DetailsScreen extends StatefulWidget {
  final Task task;
  const DetailsScreen({Key? key, required this.task}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
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
                ListView.builder(
                    itemCount: widget.task.assignedTask!.length,
                    itemBuilder: ((context, index) => ServiceTask(
                          task: widget.task,
                          count: index,
                        ))),
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
