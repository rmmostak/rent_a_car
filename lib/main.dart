import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rent_a_car/controllers/AuthController.dart';
import 'package:rent_a_car/screens/homepage.dart';
import 'package:rent_a_car/screens/login.dart';
import 'package:rent_a_car/screens/notification.dart';
import 'package:rent_a_car/screens/profiles.dart';

import 'firebase_options.dart';
import 'models/user.dart';
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
  GlobalKey<ScaffoldState> key = GlobalKey();

  AuthController authController = AuthController();

  @override
  void initState() {
    authController.getUserInfo();
    super.initState();
  }

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
          iconTheme: IconThemeData(color: Colors.blueGrey.shade800),
          elevation: 0,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Turtle',
                style: GoogleFonts.mulish(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey.shade800),
              ),
              Text(
                'Save and Steady',
                style: GoogleFonts.mulish(
                    fontSize: 14,
                    color: Colors.blueGrey.shade600),
              ),
            ],
          ),
          centerTitle: false,
        ),
        body: pages[_selectedIndex],
        key: key,
        drawer: Drawer(
          elevation: 2,
          semanticLabel: 'Main Menu',
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                ),
                title: const Text('Page 1'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.train,
                ),
                title: const Text('Page 2'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
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

  buildDrawerItem(
      {required String title,
      required Function onPressed,
      Color color = Colors.black,
      double fontSize = 20,
      FontWeight fontWeight = FontWeight.w700,
      double height = 45,
      bool isVisible = false}) {
    return SizedBox(
      height: height,
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
        // minVerticalPadding: 0,
        dense: true,
        onTap: () => onPressed(),
        title: Row(
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                  fontSize: fontSize, fontWeight: fontWeight, color: color),
            ),
            const SizedBox(
              width: 5,
            ),
            isVisible
                ? CircleAvatar(
                    backgroundColor: Colors.blueGrey,
                    radius: 15,
                    child: Text(
                      '1',
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  buildDrawer() {
    return Drawer(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              //Get.to(() => const MyProfile());
            },
            child: SizedBox(
              height: 150,
              child: DrawerHeader(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: authController.mUser.value.pic == null
                            ? const DecorationImage(
                                image: AssetImage('assets/person.png'),
                                fit: BoxFit.fill)
                            : DecorationImage(
                                image: NetworkImage(
                                    authController.mUser.value.pic!),
                                fit: BoxFit.fill)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Good Morning, ',
                            style: GoogleFonts.poppins(
                                color: Colors.black.withOpacity(0.28),
                                fontSize: 14)),
                        Text(
                          authController.mUser.value.name == null
                              ? "Mark"
                              : authController.mUser.value.name!,
                          style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        )
                      ],
                    ),
                  )
                ],
              )),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                buildDrawerItem(
                    title: 'Payment History',
                    onPressed: () {}
                ),
                buildDrawerItem(
                    title: 'Ride History', onPressed: () {}, isVisible: true),
                buildDrawerItem(title: 'Invite Friends', onPressed: () {}),
                buildDrawerItem(title: 'Promo Codes', onPressed: () {}),
                buildDrawerItem(title: 'Settings', onPressed: () {}),
                buildDrawerItem(title: 'Support', onPressed: () {}),
                buildDrawerItem(
                    title: 'Log Out',
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    }),
              ],
            ),
          ),
          const Spacer(),
          const Divider(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Column(
              children: [
                buildDrawerItem(
                    title: 'Do more',
                    onPressed: () {},
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.15),
                    height: 20),
                const SizedBox(
                  height: 20,
                ),
                buildDrawerItem(
                    title: 'Get food delivery',
                    onPressed: () {},
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withOpacity(0.15),
                    height: 20),
                buildDrawerItem(
                    title: 'Make money driving',
                    onPressed: () {},
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withOpacity(0.15),
                    height: 20),
                buildDrawerItem(
                  title: 'Rate us on store',
                  onPressed: () {},
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black.withOpacity(0.15),
                  height: 20,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
