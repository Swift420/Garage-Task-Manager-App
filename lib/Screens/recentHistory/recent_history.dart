import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:garage/Screens/details/components/details_screen.dart';
import 'package:garage/components/home_components/task_card.dart';
import 'package:garage/constants.dart';
import 'package:garage/models/task.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RecentHisotyVehicles extends StatefulWidget {
  const RecentHisotyVehicles({Key? key}) : super(key: key);

  @override
  State<RecentHisotyVehicles> createState() => _RecentHisotyVehiclesState();
}

class _RecentHisotyVehiclesState extends State<RecentHisotyVehicles> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    getRecentVehicleList();
    // print(vehiclesList);
  }

  @override
  Widget build(BuildContext context) {
    RefreshController _refreshController =
        RefreshController(initialRefresh: false);

    void _onRefresh() async {
      // monitor network fetch
      getRecentVehicleList();
      await Future.delayed(Duration(milliseconds: 1000));
      // if failed,use refreshFailed()

      _refreshController.refreshCompleted();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Color(0xFF212121), //0xFF212121
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

                SmartRefresher(
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  child: ListView.builder(
                    itemCount: recentVehiclesList.length, //recentTasks.length,

                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        /* Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                              task: recentVehiclesList[index],
                            ),
                          ),
                        );*/
                      },
                      child: TaskCard(
                        itemIndex: index,
                        task: recentVehiclesList[index],
                      ),
                      onDoubleTap: () {
                        print(recentVehiclesList[index].id);
                      },
                      onLongPress: () async {
                        await FirebaseFirestore.instance
                            .collection('recentHistory')
                            .doc(recentVehiclesList[index].id)
                            .delete();
                        setState(() {
                          getRecentVehicleList();
                        });
                      },
                    ),
                  ),
                ),

                //TaskCard(),
              ],
            )),
          ],
        ),
      ),
    );
  }

  Future getRecentVehicleList() async {
    var data = await FirebaseFirestore.instance
        .collection("recentHistory")
        .orderBy("time", descending: true)
        .get();

    setState(() {
      recentVehiclesList =
          List.from(data.docs.map((doc) => Task.fromSnapshot(doc)));
    });
  }
}
