import 'package:flutter/material.dart';
import 'package:garage/constants.dart';
import 'package:garage/models/user_class.dart';

class EmployeeDetail extends StatefulWidget {
  final User user;
  const EmployeeDetail({Key? key, required this.user}) : super(key: key);

  @override
  State<EmployeeDetail> createState() => _EmployeeDetailState();
}

class _EmployeeDetailState extends State<EmployeeDetail> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.only(left: 100.0),
          child: Text("Tasks"),
        ),
      ),
      backgroundColor: Color(0xFF212121), //0xFF212121
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
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
                    itemCount: widget.user.userTasks.length,
                    itemBuilder: ((context, index) => EmployeeTile(
                          user: widget.user,
                          count: index,
                        ))),
              ],
            )),
          ],
        ),
      ),
    );
  }
}

class EmployeeTile extends StatefulWidget {
  final User user;
  final int count;
  const EmployeeTile({Key? key, required this.user, required this.count})
      : super(key: key);

  @override
  State<EmployeeTile> createState() => _EmployeeTileState();
}

class _EmployeeTileState extends State<EmployeeTile> {
  @override
  Widget build(BuildContext context) {
    bool isChecked = false;
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20, top: 50),
        child: Container(
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(
                      width: 3.0,
                      color:
                          widget.user.userTasks[widget.count].isComplete == true
                              ? Colors.green[600]!
                              : Colors.orange),
                  left: BorderSide(
                      width: 3.0,
                      color:
                          widget.user.userTasks[widget.count].isComplete == true
                              ? Colors.green[600]!
                              : Colors.orange),
                  right: BorderSide(
                      width: 3.0,
                      color:
                          widget.user.userTasks[widget.count].isComplete == true
                              ? Colors.green[600]!
                              : Colors.orange),
                  bottom: BorderSide(
                      width: 3.0,
                      color:
                          widget.user.userTasks[widget.count].isComplete == true
                              ? Colors.green[600]!
                              : Colors.orange))),
          child: InkWell(
            child: CheckboxListTile(
                side: BorderSide(
                  color: Colors.orange,
                ),
                tileColor: Colors.white10,
                checkColor: Colors.white,
                activeColor: Colors.green,
                title: Text(
                  "${widget.user.userTasks[widget.count].employeeTask}",
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  "${widget.user.userTasks[widget.count].vehicle} - ${widget.user.userTasks[widget.count].taskType}",
                  style: TextStyle(color: Colors.white),
                ),
                value: widget.user.userTasks[widget.count].isComplete!,
                onChanged: (value) {
                  setState(() {});
                }),
          ),
        ),
      ),
    );
  }
}
