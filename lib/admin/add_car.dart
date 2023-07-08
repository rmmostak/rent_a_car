import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:rent_a_car/admin/cars.dart';

class AddCar extends StatefulWidget {
  final String uid;

  const AddCar({Key? key, required this.uid}) : super(key: key);

  @override
  State<AddCar> createState() => _AddCarState();
}

class _AddCarState extends State<AddCar> {
  GlobalKey<FormState> imgFormKey = GlobalKey<FormState>();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController modelC = TextEditingController();
  TextEditingController brandC = TextEditingController();
  TextEditingController colorC = TextEditingController();
  TextEditingController gearboxC = TextEditingController();
  TextEditingController seatC = TextEditingController();
  TextEditingController topSpeedC = TextEditingController();
  TextEditingController speed0C = TextEditingController();
  TextEditingController licenceC = TextEditingController();
  TextEditingController imgC = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  final ImagePicker _picker1 = ImagePicker();
  final ImagePicker _picker2 = ImagePicker();
  final ImagePicker _picker3 = ImagePicker();
  final ImagePicker _picker4 = ImagePicker();
  File? img1;
  File? img2;
  File? img3;
  File? img4;

  @override
  void initState() {
    print('Phone: ${widget.uid}');
    super.initState();
  }

  Future<String> uploadPic(File image, String id) async {
    String imgUrl = '';
    var fileName = Path.basename(image.path);
    var reference =
        FirebaseStorage.instance.ref().child('cars/$id/$fileName');
    UploadTask task = reference.putFile(image);
    TaskSnapshot snapshot = await task.whenComplete(() => null);
    await snapshot.ref.getDownloadURL().then((value) => {
          imgUrl = value,
        });

    return imgUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                  'Add New Car',
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
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      inputWidget(
                          context, 'Licence No', Icons.numbers, licenceC,
                          (String? input) {
                        if (input!.isEmpty) {
                          return 'Please enter car\'s licence number';
                        }
                        return null;
                      }),
                      const SizedBox(
                        height: 10,
                      ),
                      inputWidget(
                          context, 'Model', Icons.model_training, modelC,
                          (String? input) {
                        if (input!.isEmpty) {
                          return 'Please enter car\'s model';
                        }
                        return null;
                      }),
                      const SizedBox(
                        height: 10,
                      ),
                      inputWidget(context, 'Brand', Icons.star, brandC,
                          (String? input) {
                        if (input!.isEmpty) {
                          return 'Please enter car\'s brand';
                        }
                        return null;
                      }),
                      const SizedBox(
                        height: 10,
                      ),
                      inputWidget(
                          context, 'Gearbox', Icons.roundabout_right, gearboxC,
                          (String? input) {
                        if (input!.isEmpty) {
                          return 'Please enter car\'s gearbox';
                        }
                        return null;
                      }),
                      const SizedBox(
                        height: 10,
                      ),
                      inputWidget(
                          context, 'Color', Icons.color_lens_rounded, colorC,
                          (String? input) {
                        if (input!.isEmpty) {
                          return 'Please enter car\'s color';
                        }
                        return null;
                      }),
                      const SizedBox(
                        height: 10,
                      ),
                      inputWidget(context, 'Seat', Icons.event_seat, seatC,
                          (String? input) {
                        if (input!.isEmpty) {
                          return 'Please enter car\'s seat';
                        }
                        return null;
                      }),
                      const SizedBox(
                        height: 10,
                      ),
                      inputWidget(context, 'Top Speed', Icons.speed, topSpeedC,
                          (String? input) {
                        if (input!.isEmpty) {
                          return 'Please enter car\'s top speed';
                        }
                        return null;
                      }),
                      const SizedBox(
                        height: 10,
                      ),
                      inputWidget(
                          context, 'Speed (0-100)', Icons.shutter_speed,
                          speed0C, (String? input) {
                        if (input!.isEmpty) {
                          return 'Please enter car\'s speed time';
                        }
                        return null;
                      }),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Front Side of Car',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          XFile? image = await _picker1.pickImage(
                              source: ImageSource.gallery);
                          if (image != null) {
                            setState(() {
                              img1 = File(image.path);
                            });
                          }
                        },
                        child: img1 == null
                            ? Container(
                                height: 90,
                                width: MediaQuery.of(context).size.width,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
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
                                  ],
                                  shape: BoxShape.rectangle,
                                  color: Colors.blueGrey.shade50,
                                ),
                                child: const Icon(
                                  Icons.directions_car_filled_rounded,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              )
                            : Container(
                                height: 90,
                                width: MediaQuery.of(context).size.width,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.blueGrey,
                                          spreadRadius: 1)
                                    ],
                                    shape: BoxShape.rectangle,
                                    image: DecorationImage(
                                      image: FileImage(img1!),
                                      fit: BoxFit.fitWidth,
                                    )),
                              ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Back Side of Car',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          XFile? image = await _picker2.pickImage(
                              source: ImageSource.gallery);
                          if (image != null) {
                            setState(() {
                              img2 = File(image.path);
                            });
                          }
                        },
                        child: img2 == null
                            ? Container(
                          height: 90,
                          width: MediaQuery.of(context).size.width,
                          margin:
                          const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
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
                            ],
                            shape: BoxShape.rectangle,
                            color: Colors.blueGrey.shade50,
                          ),
                          child: const Icon(
                            Icons.directions_car_filled_rounded,
                            color: Colors.white,
                            size: 40,
                          ),
                        )
                            : Container(
                          height: 90,
                          width: MediaQuery.of(context).size.width,
                          margin:
                          const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.blueGrey,
                                    spreadRadius: 1)
                              ],
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                image: FileImage(img2!),
                                fit: BoxFit.fitWidth,
                              )),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Left Side of Car',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          XFile? image = await _picker3.pickImage(
                              source: ImageSource.gallery);
                          if (image != null) {
                            setState(() {
                              img3 = File(image.path);
                            });
                          }
                        },
                        child: img3 == null
                            ? Container(
                          height: 90,
                          width: MediaQuery.of(context).size.width,
                          margin:
                          const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
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
                            ],
                            shape: BoxShape.rectangle,
                            color: Colors.blueGrey.shade50,
                          ),
                          child: const Icon(
                            Icons.directions_car_filled_rounded,
                            color: Colors.white,
                            size: 40,
                          ),
                        )
                            : Container(
                          height: 90,
                          width: MediaQuery.of(context).size.width,
                          margin:
                          const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.blueGrey,
                                    spreadRadius: 1)
                              ],
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                image: FileImage(img3!),
                                fit: BoxFit.fitWidth,
                              )),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Right Side of Car',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          XFile? image = await _picker4.pickImage(
                              source: ImageSource.gallery);
                          if (image != null) {
                            setState(() {
                              img4 = File(image.path);
                            });
                          }
                        },
                        child: img4 == null
                            ? Container(
                          height: 90,
                          width: MediaQuery.of(context).size.width,
                          margin:
                          const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
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
                            ],
                            shape: BoxShape.rectangle,
                            color: Colors.blueGrey.shade50,
                          ),
                          child: const Icon(
                            Icons.directions_car_filled_rounded,
                            color: Colors.white,
                            size: 40,
                          ),
                        )
                            : Container(
                          height: 90,
                          width: MediaQuery.of(context).size.width,
                          margin:
                          const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.blueGrey,
                                    spreadRadius: 1)
                              ],
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                image: FileImage(img4!),
                                fit: BoxFit.fitWidth,
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          child: const Text('Add Car'),
                          onPressed: () async {
                            if (formKey.currentState!.validate() &&
                                img1?.path != null &&
                                img2?.path != null &&
                                img3?.path != null &&
                                img4?.path != null) {
                              FirebaseFirestore fireStore =
                                  FirebaseFirestore.instance;
                              var id = fireStore.collection('cars').doc().id;
                              print('ID: $id \n${uploadPic(img1!, id)}');
                              fireStore.collection('cars').doc(id).set({
                                'id': id,
                                'uid': widget.uid,
                                'licence': licenceC.text,
                                'model': modelC.text,
                                'brand': brandC.text,
                                'gearbox': gearboxC.text,
                                'color': colorC.text,
                                'seat': seatC.text,
                                'topSpeed': topSpeedC.text,
                                'speed0': speed0C.text,
                                'front': await uploadPic(img1!, id),
                                'back': await uploadPic(img2!, id),
                                'left': await uploadPic(img3!, id),
                                'right': await uploadPic(img4!, id),
                              }).then((value) => {
                                    Navigator.pop(context),
                                  });
                            } else {
                              print('some object clicked!');
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ]),
        ),
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
        TextFormField(
            textCapitalization: TextCapitalization.words,
            controller: controller,
            validator: (input) => validator(input),
            readOnly: readOnly,
            style: const TextStyle(
              fontSize: 18,
            ),
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Icon(
                    iconData,
                    color: Colors.blueGrey,
                  ),
                ),
                border: const OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.green,
                  width: 1,
                  style: BorderStyle.solid,
                )))),
      ],
    );
  }
}
