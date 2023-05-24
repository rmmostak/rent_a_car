import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../models/user.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var mUser = UserModel().obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController fromAddressController = TextEditingController();
  TextEditingController toAddressController = TextEditingController();
  TextEditingController seatNumController = TextEditingController();
  TextEditingController carController = TextEditingController();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController fareController = TextEditingController();

  // Initial Selected Value
  String dropdownValue = 'Choose Car';

  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("USA"),value: "USA"),
      DropdownMenuItem(child: Text("Canada"),value: "Canada"),
      DropdownMenuItem(child: Text("Brazil"),value: "Brazil"),
      DropdownMenuItem(child: Text("England"),value: "England"),
    ];
    return menuItems;
  }

  void getUserInfo() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .snapshots()
        .listen((event) {
      mUser.value = UserModel.fromJson(event.data()!);
      print('DataFromBase: ${event.data()}');
    });
  }

  @override
  void initState() {
    removePreviousValue();
    getUserInfo();
    super.initState();
  }

  void removePreviousValue() {
    fromAddressController.text = '';
    toAddressController.text = '';
    seatNumController.text = '';
    carController.text = '';
    fromDateController.text = '';
    toDateController.text = '';
    fareController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        child: Expanded(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(
                      flex: 3,
                      child: Text(
                        'From',
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Expanded(
                      flex: 8,
                      child: TextFormField(
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(5),
                              hintText: 'From address',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.blueGrey,
                                width: 0.05,
                                style: BorderStyle.solid,
                              ))))),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(
                      flex: 3,
                      child: Text(
                        'To',
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Expanded(
                      flex: 8,
                      child: TextFormField(
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(5),
                              hintText: 'Destination address',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.blueGrey,
                                width: 0.05,
                                style: BorderStyle.solid,
                              ))))),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(
                      flex: 3,
                      child: Text(
                        'Seat',
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Expanded(
                      flex: 8,
                      child: TextFormField(
                          keyboardType: TextInputType.number,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(5),
                              hintText: 'Desired seat',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.blueGrey,
                                width: 0.05,
                                style: BorderStyle.solid,
                              ))))),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(
                      flex: 3,
                      child: Text(
                        'Car',
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Expanded(
                    flex: 8,
                    child: DropdownButtonFormField(
                      value: dropdownValue,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(5),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.blueGrey,
                            width: 0.05,
                            style: BorderStyle.solid,
                          ))),
                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: items.map((String item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(item),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() async {
                          dropdownValue = newValue!;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(
                      flex: 3,
                      child: Text(
                        'Journey',
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Expanded(
                      flex: 4,
                      child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: fromDateController,
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                lastDate: DateTime(2100));

                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('dd MMM yyyy').format(pickedDate);
                              setState(() {
                                fromDateController.text = formattedDate;
                              });
                            }
                          },
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(5),
                              hintText: 'From',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.blueGrey,
                                width: 0.05,
                                style: BorderStyle.solid,
                              ))))),
                  const Spacer(
                    flex: 1,
                  ),
                  Expanded(
                      flex: 4,
                      child: TextFormField(
                          controller: toDateController,
                          keyboardType: TextInputType.number,
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                lastDate: DateTime(2100));

                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('dd MMM yyyy').format(pickedDate);
                              setState(() {
                                toDateController.text = formattedDate;
                              });
                            }
                          },
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 0),
                              hintText: 'To',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.blueGrey,
                                width: 0.05,
                                style: BorderStyle.solid,
                              ))))),
                ],
              ),
            ),
          ]),
        ));
  }
}
