import 'package:flutter/material.dart';
import 'package:garage/constants.dart';
import 'package:garage/models/user_class.dart';

class EmployeeCard extends StatelessWidget {
  const EmployeeCard({
    Key? key,
    required this.itemIndex,
    required this.user,
  }) : super(key: key);
  final int itemIndex;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      //color: Colors.blueAccent,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22), color: kCardColor),
          ),
          Positioned(
            right: 10,
            top: 45,
            child: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 30,
            ),
          ),
          Positioned(
              top: 50,
              //bottom: 0,
              left: 0,
              child: SizedBox(
                height: 80,
                width: MediaQuery.of(context).size.width - 50,
                child: Column(
                  children: [
                    Text(
                      user.name!,
                      //user.name,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              )),
          Positioned(
            top: 49,
            left: 10,
            child: Icon(
              Icons.person,
              color: Colors.green,
              size: 30,
            ),
          )
        ],
      ),
    );
  }
}
