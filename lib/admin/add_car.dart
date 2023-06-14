import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddCar extends StatefulWidget {
  const AddCar({Key? key}) : super(key: key);

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
  File? img1;
  File? img2;
  File? img3;
  File? img4;

  getImage(ImageSource source, int img) async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        switch (img) {
          case 1:
            img1 = File(image.path);
            break;
          case 2:
            img2 = File(image.path);
            break;
          case 3:
            img3 = File(image.path);
            break;
          case 4:
            img4 = File(image.path);
            break;
        }
      });
    }
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
                    /*physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,*/
                    children: [
                      inputWidget(context, 'Licence No', Icons.numbers, modelC,
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
                          context, 'Gearbox', Icons.roundabout_right, colorC,
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
                      inputWidget(context, 'Seat', Icons.event_seat, colorC,
                          (String? input) {
                        if (input!.isEmpty) {
                          return 'Please enter car\'s seat';
                        }
                        return null;
                      }),
                      const SizedBox(
                        height: 10,
                      ),
                      inputWidget(context, 'Top Speed', Icons.speed, colorC,
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
                          context, 'Speed (0-100)', Icons.shutter_speed, colorC,
                          (String? input) {
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
                        child: ElevatedButton(
                          child: const Text('Add Car Photo'),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              print('some object');
                            } else {
                              showModalBottomSheet<void>(
                                  context: context,
                                  isDismissible: true,
                                  isScrollControlled: true,
                                  builder: (BuildContext context) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom),
                                      child: Container(
                                        color: Colors.white30,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.8,
                                        child: Container(
                                            padding: const EdgeInsets.all(20),
                                            child: Form(
                                              key: imgFormKey,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: const Text(
                                                      'Add Car Image',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  const Text(
                                                      'Front Side of Car'),
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        getImage(
                                                            ImageSource.gallery,
                                                            1);
                                                      });
                                                    },
                                                    child: img1 == null
                                                        ? Container(
                                                            height: 90,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            margin:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        10),
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .rectangle,
                                                              color: Colors
                                                                  .blueGrey
                                                                  .shade50,
                                                            ),
                                                            child: const Icon(
                                                              Icons
                                                                  .directions_car_filled_rounded,
                                                              color:
                                                                  Colors.white,
                                                              size: 40,
                                                            ),
                                                          )
                                                        : Container(
                                                            height: 90,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            margin:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        10),
                                                            decoration:
                                                                BoxDecoration(
                                                                    boxShadow: const [
                                                                  BoxShadow(
                                                                      color: Colors
                                                                          .blueGrey,
                                                                      spreadRadius:
                                                                          1)
                                                                ],
                                                                    shape: BoxShape
                                                                        .rectangle,
                                                                    image:
                                                                        DecorationImage(
                                                                      image: FileImage(
                                                                          img1!),
                                                                      fit: BoxFit
                                                                          .fitWidth,
                                                                    )),
                                                          ),
                                                  ),
                                                  const Text(
                                                      'Back Side of Car'),
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        getImage(
                                                            ImageSource.gallery,
                                                            2);
                                                      });
                                                    },
                                                    child: img2 == null
                                                        ? Container(
                                                            height: 90,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            margin:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        10),
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .rectangle,
                                                              color: Colors
                                                                  .blueGrey
                                                                  .shade50,
                                                            ),
                                                            child: const Icon(
                                                              Icons
                                                                  .directions_car_filled_rounded,
                                                              color:
                                                                  Colors.white,
                                                              size: 40,
                                                            ),
                                                          )
                                                        : Container(
                                                            height: 90,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            margin:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        10),
                                                            decoration:
                                                                BoxDecoration(
                                                                    boxShadow: const [
                                                                  BoxShadow(
                                                                      color: Colors
                                                                          .blueGrey,
                                                                      spreadRadius:
                                                                          1)
                                                                ],
                                                                    shape: BoxShape
                                                                        .rectangle,
                                                                    image:
                                                                        DecorationImage(
                                                                      image: FileImage(
                                                                          img2!),
                                                                      fit: BoxFit
                                                                          .fitWidth,
                                                                    )),
                                                          ),
                                                  ),
                                                  const Text(
                                                      'Left Side of Car'),
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        getImage(
                                                            ImageSource.gallery,
                                                            3);
                                                      });
                                                    },
                                                    child: img3 == null
                                                        ? Container(
                                                            height: 90,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            margin:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        10),
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .rectangle,
                                                              color: Colors
                                                                  .blueGrey
                                                                  .shade50,
                                                            ),
                                                            child: const Icon(
                                                              Icons
                                                                  .directions_car_filled_rounded,
                                                              color:
                                                                  Colors.white,
                                                              size: 40,
                                                            ),
                                                          )
                                                        : Container(
                                                            height: 90,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            margin:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        10),
                                                            decoration:
                                                                BoxDecoration(
                                                                    boxShadow: const [
                                                                  BoxShadow(
                                                                      color: Colors
                                                                          .blueGrey,
                                                                      spreadRadius:
                                                                          1)
                                                                ],
                                                                    shape: BoxShape
                                                                        .rectangle,
                                                                    image:
                                                                        DecorationImage(
                                                                      image: FileImage(
                                                                          img3!),
                                                                      fit: BoxFit
                                                                          .fitWidth,
                                                                    )),
                                                          ),
                                                  ),
                                                  const Text(
                                                      'Right Side of Car'),
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        getImage(
                                                            ImageSource.gallery,
                                                            4);
                                                      });
                                                    },
                                                    child: img4 == null
                                                        ? Container(
                                                            height: 90,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            margin:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        10),
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .rectangle,
                                                              color: Colors
                                                                  .blueGrey
                                                                  .shade50,
                                                            ),
                                                            child: const Icon(
                                                              Icons
                                                                  .directions_car_filled_rounded,
                                                              color:
                                                                  Colors.white,
                                                              size: 40,
                                                            ),
                                                          )
                                                        : Container(
                                                            height: 90,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            margin:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        10),
                                                            decoration:
                                                                BoxDecoration(
                                                                    boxShadow: const [
                                                                  BoxShadow(
                                                                      color: Colors
                                                                          .blueGrey,
                                                                      spreadRadius:
                                                                          1)
                                                                ],
                                                                    shape: BoxShape
                                                                        .rectangle,
                                                                    image:
                                                                        DecorationImage(
                                                                      image: FileImage(
                                                                          img4!),
                                                                      fit: BoxFit
                                                                          .fitWidth,
                                                                    )),
                                                          ),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: ElevatedButton(
                                                      child: const Text(
                                                          'Add Car Photo'),
                                                      onPressed: () {
                                                        if (imgFormKey
                                                            .currentState!
                                                            .validate()) {
                                                          print(
                                                              '${img1?.path.toString()}\n${img2?.path.toString()}\n${img3?.path.toString()}\n${img4?.path.toString()}');
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ),
                                    );
                                  });
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
            textCapitalization: TextCapitalization.words,
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
