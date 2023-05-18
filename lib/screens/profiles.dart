import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:rent_a_car/widgets/top_screen.dart';

import '../main.dart';

class Profiles extends StatefulWidget {
  const Profiles({Key? key}) : super(key: key);

  @override
  State<Profiles> createState() => _ProfilesState();
}

class _ProfilesState extends State<Profiles> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameControl = TextEditingController();
  TextEditingController addressControl = TextEditingController();
  TextEditingController nidControl = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  getImage(ImageSource source) async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  Future<String> uploadPic(File image) async {
    String imgUrl = '';
    var fileName = Path.basename(image.path);
    User? user = FirebaseAuth.instance.currentUser;
    var reference =
        FirebaseStorage.instance.ref().child('users/${user?.uid}/$fileName');
    UploadTask task = reference.putFile(image);
    TaskSnapshot snapshot = await task.whenComplete(() => null);
    await snapshot.ref.getDownloadURL().then((value) => {
          imgUrl = value,
        });

    return imgUrl;
  }

  saveUser() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    String imgUrl = '';
    if (selectedImage != null) {
      imgUrl = await uploadPic(selectedImage!);
    }
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    fireStore.collection('users').doc(uid).set({
      'uid': uid,
      'name': nameControl.text,
      'address': addressControl.text,
      'pic': imgUrl,
      'nid': nidControl.text,
    }).then((value) => {
          nameControl.clear(),
          addressControl.clear(),
          nidControl.clear(),
          selectedImage = null,
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyHomePage())),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: formKey,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                child: Stack(
                  children: [
                    TopScreen(),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: InkWell(
                        onTap: () {
                          getImage(ImageSource.gallery);
                        },
                        child: selectedImage == null
                            ? Container(
                                height: 120,
                                width: 120,
                                margin: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blueGrey.shade50,
                                ),
                                child: const Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              )
                            : Container(
                                height: 120,
                                width: 120,
                                margin: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.blueGrey,
                                          spreadRadius: 1)
                                    ],
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: FileImage(selectedImage!),
                                      fit: BoxFit.fitWidth,
                                    )),
                              ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  inputWidget(
                      context, 'Name', Icons.account_circle, nameControl,
                      (String? input) {
                    if (input!.isEmpty) {
                      return 'Enter your full name';
                    }
                    return null;
                  }),
                  const SizedBox(
                    height: 15,
                  ),
                  inputWidget(
                      context, 'NID', Icons.credit_card_rounded, nidControl,
                      (String? input) {
                    if (input!.isEmpty) {
                      return 'Enter your present address';
                    }
                    return null;
                  }),
                  const SizedBox(
                    height: 15,
                  ),
                  inputWidget(
                      context, 'Address', Icons.location_on, addressControl,
                      (String? input) {
                    if (input!.isEmpty) {
                      return 'Enter your present address';
                    }
                    return null;
                  }),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.blueGrey,
                    child: TextButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          saveUser();
                        }
                      },
                      child: Text(
                        'Save',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
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
            //onTap: onTap!(),
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
