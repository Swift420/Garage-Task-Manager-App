import 'package:flutter/material.dart';
import 'package:garage/components/home_components/countdown_painter.dart';
import 'package:garage/constants.dart';
import 'package:garage/models/task.dart';
import 'package:intl/intl.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    Key? key,
    required this.task,
    required this.itemIndex,
    this.press,
  }) : super(key: key);
  final Task task;
  final int itemIndex;
  final Function? press;
  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("hh:mm a");

    Size size = MediaQuery.of(context).size;
    int noOfTasks = task.assignedTask!.length;
    int numOfCompleted = task.assignedTask!
        .where((element) => element.isComplete == true)
        .length;
    int tasksLeft = noOfTasks - numOfCompleted;

    double percent = (numOfCompleted / noOfTasks) * 100;
    if (percent.isNaN) {
      percent = 0;
    }
    double percentConverted = percent / 100;
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
      height: 160,
      // color: kCardColor,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 136,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: kCardColor,
            ),
          ),
          Positioned(
            top: 70,
            right: 20,
            child: CustomPaint(
              foregroundPainter: CountdownPainter(
                bgColor: kBGColor,
                lineColor: _getColor(context, percentConverted),
                percent: percentConverted,
                width: 4.0,
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Text(
                      //"$noOfTasks",
                      "${percent.isNaN ? 0 : percent.toInt()}%",

                      // "${percent}%",
                      style: TextStyle(
                        color: _getColor(context, percentConverted),
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: SizedBox(
              child: SizedBox(
                height: 136,
                width: size.width - 150,
                child: Column(
                  children: [
                    SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Icon(
                            Icons.assignment_outlined,
                            color: Colors.greenAccent[400],
                            size: 20,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            task.title!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: Colors.greenAccent[400],
                            size: 20,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            task.owner!,
                            style: TextStyle(
                              color: kTextColor,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Icon(
                            Icons.query_builder,
                            color: Colors.greenAccent[400],
                            size: 20,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${DateTime.now().weekday == task.time!.weekday ? "Today" : DateFormat.EEEE().format(task.time!)}, ${dateFormat.format(task.time!)}",
                            style: const TextStyle(
                              color: kTextColor,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _getColor(BuildContext context, double percent) {
    if (percent >= 0.35) {
      return Colors.greenAccent[400];
    }
    return kHourColor;
  }
}
