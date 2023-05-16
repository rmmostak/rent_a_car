import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:rent_a_car/controllers/AuthController.dart';
import 'package:rent_a_car/screens/login.dart';

import '../widgets/top_screen.dart';

class VerifyOTP extends StatefulWidget {
  String phone;

  VerifyOTP(this.phone);

  @override
  State<VerifyOTP> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController txtOTP = TextEditingController();

  AuthController controller = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    controller.authByPhone(widget.phone);
    print('Phone Number: ${widget.phone}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          color: Colors.white,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    TopScreen(),
                    Positioned(
                      top: 40,
                      left: 0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => Login()),
                              (route) => false);
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Verify phone number',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Pinput(
                        length: 6,
                        controller: txtOTP,
                        onCompleted: (otp) {
                          controller.verifyOTP(context, otp);
                        },
                        defaultPinTheme: PinTheme(
                          width: 56,
                          height: 56,
                          textStyle: const TextStyle(
                              fontSize: 20,
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueGrey.shade300),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        showCursor: true,
                        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                RichText(
                  textAlign: TextAlign.start,
                  text: const TextSpan(
                      style: TextStyle(fontSize: 14, color: Colors.blueGrey),
                      children: [
                        TextSpan(text: 'Resend code in '),
                        TextSpan(
                            text: '10 seconds',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey)),
                      ]),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          )),
    );
  }
}
