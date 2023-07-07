import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rent_a_car/admin/add_car.dart';

import '../controllers/AuthController.dart';

class Cars extends StatefulWidget {
  const Cars({Key? key}) : super(key: key);

  @override
  State<Cars> createState() => _CarsState();
}

class _CarsState extends State<Cars> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController phoneC = TextEditingController();

  AuthController controller = Get.put(AuthController());
  String msg = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                        border: Border.all(width: 1, color: Colors.grey.shade300),
                      ),
                      child: const Icon(
                        Icons.keyboard_arrow_left,
                        color: Colors.black,
                        size: 24,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text(
                    'Cars',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          /*Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddCar()));*/
          showModalBottomSheet<void>(
              context: context,
              isDismissible: true,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Container(
                    color: Colors.white30,
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: const Text(
                                  'Add New Car',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                  keyboardType: TextInputType.phone,
                                  controller: phoneC,
                                  validator: (val) => val!.isEmpty
                                      ? 'Please enter your phone number'
                                      : (val.length == 14)
                                          ? null
                                          : 'Please provide number with country code',
                                  decoration: const InputDecoration(
                                      labelText: 'Driver\'s Phone No',
                                      contentPadding: EdgeInsets.all(10),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: Colors.green,
                                        width: 1,
                                        style: BorderStyle.solid,
                                      )))),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: ElevatedButton(
                                  child: const Text(
                                    'Add Car Details',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                        final result = await FirebaseFirestore
                                            .instance
                                            .collection('users')
                                            .where('phone',
                                                isEqualTo: phoneC.text)
                                            .get();

                                        List searchList = result.docs
                                            .map((e) => e.data())
                                            .toList();
                                        print(searchList);
                                        if (searchList.isEmpty) {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Row(
                                                    children: const [
                                                      Icon(
                                                        Icons.warning_amber,
                                                        color: Colors.red,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        'Alert',
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      ),
                                                    ],
                                                  ), //const Text('Alert'),
                                                  content: const Text(
                                                      'This driver is not registered yet or the phone number is wrong.'),
                                                  actions: [
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          child: const Text(
                                                            'Close',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          )),
                                                    )
                                                  ],
                                                );
                                              });
                                        } else {
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (context) => AddCar()));
                                        }
                                    }
                                  },
                                ),
                              ),
                              Text(
                                msg,
                                style: const TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 14,
                                ),
                              )
                            ],
                          ),
                        )),
                  ),
                );
              });
        },
        backgroundColor: Colors.blueGrey.shade900,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget inputWidget(BuildContext context, String label, IconData iconData,
      TextEditingController controller, Function validator,
      {Function? onTap, bool readOnly = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.blueGrey,
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Container(
          //width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: BoxDecoration(
              color: Colors.blueGrey.shade50,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              border: Border.all(
                  width: 1,
                  style: BorderStyle.solid,
                  color: Colors.blueGrey.shade100),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.05),
                  spreadRadius: 0,
                  blurRadius: 0,
                )
              ]),
          child: TextFormField(
            keyboardType: TextInputType.phone,
            initialValue: '+88',
            controller: controller,
            validator: (input) => validator(input),
            readOnly: readOnly,
            style: const TextStyle(
              fontSize: 18,
            ),
            decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Icon(
                    iconData,
                    color: Colors.blueGrey,
                  ),
                ),
                border: InputBorder.none),
          ),
        )
      ],
    );
  }
}
