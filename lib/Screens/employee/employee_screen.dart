import 'package:flutter/material.dart';
import 'package:garage/Screens/details/components/employee_detail_screen.dart';
import 'package:garage/components/employee_components/employee_card.dart';
import 'package:garage/constants.dart';
import 'package:garage/models/task.dart';
import 'package:garage/models/user_class.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF212121),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: kDefaultPadding / 2),
            Expanded(
                child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF212121),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                    ),
                  ),
                ),

                ListView.builder(
                    itemCount: users.length,
                    itemBuilder: ((context, index) => InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EmployeeDetail(
                                  user: users[index],
                                ),
                              ),
                            );
                          },
                          child: EmployeeCard(
                            itemIndex: index,
                            user: users[index],
                          ),
                        )))
                //EmployeeCard(),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
