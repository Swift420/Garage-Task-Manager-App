import 'package:flutter/material.dart';
import 'package:garage/components/home_components/countdown_painter.dart';
import 'package:garage/constants.dart';
import 'package:garage/models/task.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class RecentTasks extends StatefulWidget {
  const RecentTasks(
      {Key? key,
      required this.count,
      required this.tasksLeft,
      required this.task});
  final int count;
  final int tasksLeft;
  final Task task;
  @override
  State<RecentTasks> createState() => _RecentTasksState();
}

class _RecentTasksState extends State<RecentTasks> {
  DateFormat dateFormat = DateFormat("hh:mm a");

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        Task task = recentTasks[index];
        double percentConverted = 10 / 100;
        return Row(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 30),
              height: 150,
              width: 10,
              decoration: BoxDecoration(
                color: Colors.greenAccent[400],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 30),
              padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
              height: 150,
              width: 326,
              decoration: const BoxDecoration(
                color: Color(
                  0xFF282B30,
                ),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Stack(children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    task.title!,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.alarm,
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
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
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
                        style: const TextStyle(
                          color: kTextColor,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  )
                ]),
                Positioned(
                  right: 0.0,
                  top: 30,
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
                            "0",
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
                const Positioned(
                  right: 0.0,
                  top: 87,
                  child: Text(
                    "Completed",
                    style: TextStyle(
                      color: kTextColor,
                    ),
                  ),
                ),
              ]),
            ),
          ],
        );
      },
    );
  }

  _getColor(BuildContext context, double percent) {
    if (percent >= 0.35) {
      return Colors.greenAccent[400];
    }
    return kHourColor;
  }
}
