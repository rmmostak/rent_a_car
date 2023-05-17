import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rent_a_car/controllers/AuthController.dart';
import 'package:rent_a_car/screens/homepage.dart';
import 'package:rent_a_car/screens/login.dart';
import 'package:rent_a_car/screens/notification.dart';
import 'package:rent_a_car/screens/profiles.dart';

import 'firebase_options.dart';
import 'screens/history.dart';
import 'screens/profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.mulishTextTheme(),
      ),
      home: Login(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List pages = [Home(), Notifications(), History(), Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          brightness: Brightness.light,
          title: Text(
            'Rent A Car',
            style: GoogleFonts.mulish(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade800),
          ),
          centerTitle: false,
          actions: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Icon(
                Icons.menu,
                color: Colors.blueGrey.shade800,
                size: 24,
              ),
            )
          ],
        ),
        body: pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.blueGrey,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.notifications,
                  color: Colors.blueGrey,
                ),
                label: 'Notification'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.history,
                  color: Colors.blueGrey,
                ),
                label: 'History'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color: Colors.blueGrey,
                ),
                label: 'Profile'),
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
