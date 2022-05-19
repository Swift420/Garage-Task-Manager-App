import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garage/Screens/details/components/employee_detail_screen.dart';
import 'package:garage/components/employee_components/employee_card.dart';
import 'package:garage/constants.dart';
import 'package:garage/models/user_class.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SingleEmployee extends StatefulWidget {
  const SingleEmployee({Key? key}) : super(key: key);

  @override
  State<SingleEmployee> createState() => _SingleEmployeeState();
}

class _SingleEmployeeState extends State<SingleEmployee> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    // print(vehiclesList);
  }

  @override
  Widget build(BuildContext context) {
    RefreshController _refreshController =
        RefreshController(initialRefresh: false);

    void _onRefresh() async {
      // monitor network fetch
      getEmployeeList();
      await Future.delayed(Duration(milliseconds: 1000));
      // if failed,use refreshFailed()

      _refreshController.refreshCompleted();
    }

    Box box = Hive.box('userBox');
    return SafeArea(
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

              SmartRefresher(
                controller: _refreshController,
                onRefresh: _onRefresh,
                child: ListView.builder(
                    itemCount: employeeList.length,
                    itemBuilder: ((context, index) => InkWell(
                          onTap: () {
                            if (box.get(98) == employeeList[index].name ||
                                box.get(99) == true) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EmployeeDetail(
                                    user: employeeList[index],
                                  ),
                                ),
                              );
                            } else {
                              showemployeeErrorToast();
                            }
                          },
                          child: EmployeeCard(
                            itemIndex: index,
                            user: employeeList[index],
                          ),
                        ))),
              )
              //EmployeeCard(),
            ],
          )),
        ],
      ),
    );
  }

  Future getEmployeeList() async {
    var data = await FirebaseFirestore.instance
        .collection("users")
        .orderBy("name")
        .get();
    if (this.mounted) {
      setState(() {
        employeeList =
            List.from(data.docs.map((doc) => User.fromSnapshot(doc)));
      });
    }
  }

  void showemployeeErrorToast() =>
      Fluttertoast.showToast(msg: "Unauthorised User");
}
