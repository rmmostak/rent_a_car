import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rent_a_car/screens/verify_otp.dart';
import 'package:rent_a_car/widgets/top_screen.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController txtPhone = TextEditingController();

  @override
  void initState() {
    super.initState();

    txtPhone.text = '+880';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopScreen(),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Register with phone',
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
                    TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: txtPhone,
                        validator: (val) => val!.isEmpty
                            ? 'Please enter your phone number'
                            : (val.length == 14)
                                ? null
                                : 'Please provide number with country code',
                        decoration: const InputDecoration(
                            labelText: 'Phone',
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.green,
                              width: 1,
                              style: BorderStyle.solid,
                            )))),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Colors.blueGrey.shade800),
                          padding: MaterialStateProperty.resolveWith((states) =>
                              const EdgeInsets.symmetric(vertical: 10)),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: const Text(
                            'Get Verification Code',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => VerifyOTP(txtPhone.text)), (route) => false);
                          }
                        }),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                      children: [
                        TextSpan(
                            text:
                                'By creating this account, you are agree to the '),
                        TextSpan(
                            text: 'Terms of Services',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: ' and '),
                        TextSpan(
                            text: 'Privacy & Policy',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ]),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
