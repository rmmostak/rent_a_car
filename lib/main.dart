import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rent_a_car/controllers/AuthController.dart';
import 'package:rent_a_car/screens/homepage.dart';
import 'package:rent_a_car/screens/login.dart';
import 'package:rent_a_car/screens/notification.dart';
import 'package:rent_a_car/screens/profile.dart';
import 'package:rent_a_car/screens/search_dest.dart';

import 'firebase_options.dart';
import 'screens/history.dart';

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

  List pages = [Home(), Notifications(), History()];

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
                    fontSize: 14, color: Colors.blueGrey.shade600),
              ),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const SearchDest())),
                icon: const Icon(Icons.search))
          ],
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
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.blueGrey,
                ),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Obx(() => authController.mUser.value.name != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                  color: Colors.white,
                                  image: authController.mUser.value.pic == null
                                      ? const DecorationImage(
                                          image: AssetImage(
                                              'assets/images/bmw2.png'),
                                          fit: BoxFit.fill)
                                      : DecorationImage(
                                          image: NetworkImage(
                                              authController.mUser.value.pic!),
                                          fit: BoxFit.fill)),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              authController.mUser.value.name.toString(),
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                            Text(
                              authController.mUser.value.phone.toString(),
                              textAlign: TextAlign.left,
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          ],
                        )
                      : const Text('You are not logged in...')),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.home,
                ),
                title: const Text('Dashboard'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyHomePage()));
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.account_circle,
                ),
                title: const Text('Profile'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Profile()));
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.app_blocking_outlined,
                ),
                title: const Text('About'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.policy,
                ),
                title: const Text('Policy'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.share,
                ),
                title: const Text('Share'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.logout,
                ),
                title: const Text('Logout'),
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
