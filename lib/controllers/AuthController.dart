import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rent_a_car/screens/profiles.dart';

import '../main.dart';
import '../models/user.dart';

class AuthController extends GetxController {
  String userId = '';
  var verId = '';
  int? resendTokenId;
  bool isAuthorized = false;
  dynamic credentials;
  FirebaseAuth auth = FirebaseAuth.instance;

  authByPhone(String phone) async {
    try {
      credentials = null;
      await auth.verifyPhoneNumber(
          phoneNumber: phone,
          timeout: Duration(seconds: 60),
          verificationCompleted: (PhoneAuthCredential credential) async {
            log('Completed');
            credentials = credential;
            UserCredential result = await auth.signInWithCredential(credential);
            User? user = result.user;
          },
          forceResendingToken: resendTokenId,
          verificationFailed: (FirebaseAuthException e) {
            log('Error: ${e.message}');
            if (e.code == 'invalid-phone-number') {
              debugPrint('The provided phone number is not valid.');
            }
          },
          codeSent: (String verificationCode, int? resendToken) async {
            log('Code is sent');
            verId = verificationCode;
            resendTokenId = resendToken;
          },
          codeAutoRetrievalTimeout: (String verificationId) {});
    } catch (e) {
      log('Error: $e');
    }
  }

  verifyOTP(BuildContext context, String otp) async {
    AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verId, smsCode: otp);

    UserCredential result =
    await auth.signInWithCredential(credential);

    User? user = result.user;
    if (user != null) {
      print('${user.uid} \t ${user.phoneNumber}');
      findRoute(context);
    } else {
      print("Error");
    }
  }

  findRoute(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get()
          .then((value) => {
                if (value.exists)
                  {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyHomePage())),
                  }
                else
                  {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Profiles())),
                  }
              });
    }
  }

  var mUser = UserModel().obs;

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
}
