import 'package:flutter/material.dart';
import 'package:garage/Screens/addToHome/add_to_home.dart';
import 'package:garage/Screens/employee/employee_screen.dart';
import 'package:garage/Screens/home/home.dart';
import 'package:garage/models/task.dart';

class BottomNav extends StatefulWidget {
  //final Task task;
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 1;
  List _widgetOptions = [AddToHome(), Home(), EmployeeScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Color(0xFF212121),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: Colors.orangeAccent,
        unselectedItemColor: Colors.white,
        //backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(
            0xFF212121), //Color(0xFF212121), Color(0xFF3d3d3d), //Color(0xFFF5F6F9),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: "",
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: _widgetOptions.elementAt(_currentIndex),
    );
  }
}
