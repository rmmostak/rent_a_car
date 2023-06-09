import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class Drivers extends StatefulWidget {
  const Drivers({Key? key}) : super(key: key);

  @override
  State<Drivers> createState() => _DriversState();
}

class _DriversState extends State<Drivers> {
  GlobalKey<FormState> dialogKey = GlobalKey<FormState>();
  TextEditingController txtOTP = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nidControl = TextEditingController();
  TextEditingController nameControl = TextEditingController();
  TextEditingController phoneControl = TextEditingController();

  showBottomSheet(BuildContext context) {
    return showModalBottomSheet<void>(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              color: Colors.white30,
              height: 230,
              child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: dialogKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: const Text(
                            'Verify phone number',
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
                        Pinput(
                          length: 6,
                          controller: txtOTP,
                          onCompleted: (otp) {
                            //controller.verifyOTP(context, otp);
                          },
                          defaultPinTheme: PinTheme(
                            width: 50,
                            height: 50,
                            textStyle: const TextStyle(
                                fontSize: 20,
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.blueGrey.shade300),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          showCursor: true,
                          pinputAutovalidateMode:
                              PinputAutovalidateMode.onSubmit,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(5),
                          child: ElevatedButton(
                            child: const Text(
                              'Verify',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                print('some object');
                              } else {
                                print('some object not comply');
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
                    'Drivers',
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
          showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                      color: Colors.white30,
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: const Text(
                                'Add New Driver',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            inputWidget(
                                context, 'Name', Icons.account_box, nameControl,
                                (String? input) {
                              if (input!.isEmpty) {
                                return 'Please enter user\'s name';
                              }
                              return null;
                            }),
                            const SizedBox(
                              height: 10,
                            ),
                            inputWidget(
                                context, 'Phone', Icons.phone, phoneControl,
                                (String? input) {
                              if (input!.isEmpty) {
                                return 'Please enter user\'s phone';
                              }
                              return null;
                            }),
                            const SizedBox(
                              height: 10,
                            ),
                            inputWidget(
                                context,
                                'NID',
                                Icons.credit_card_rounded,
                                nidControl, (String? input) {
                              if (input!.isEmpty) {
                                return 'Please enter user\'s NID';
                              }
                              return null;
                            }),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                child: const Text('Add New Driver'),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    print('some object');
                                    showBottomSheet(context);
                                  } else {
                                    showBottomSheet(context);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      )),
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
