import 'package:flutter/material.dart';
import 'package:rent_a_car/admin/cars.dart';
import 'package:rent_a_car/admin/drivers.dart';
import 'package:rent_a_car/admin/users.dart';

import '../controllers/AuthController.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {


  int _selectedIndex = 0;
  GlobalKey<ScaffoldState> key = GlobalKey();

  AuthController authController = AuthController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List pages = [Users(), Drivers(), Cars()];




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
        key: key,
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.supervisor_account,
                  color: Colors.blueGrey,
                ),
                label: 'Users'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.assistant_direction_outlined,
                  color: Colors.blueGrey,
                ),
                label: 'Drivers'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.directions_car_filled_rounded,
                  color: Colors.blueGrey,
                ),
                label: 'Cars'),
          ],
          currentIndex: _selectedIndex,
          backgroundColor: Colors.blueGrey.shade100,
          selectedItemColor: Colors.blueGrey.shade900,
          selectedLabelStyle:
          const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          onTap: _onItemTapped,
        ));
  }
}
