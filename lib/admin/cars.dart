import 'package:flutter/material.dart';
import 'package:rent_a_car/admin/add_car.dart';

class Cars extends StatefulWidget {
  const Cars({Key? key}) : super(key: key);

  @override
  State<Cars> createState() => _CarsState();
}

class _CarsState extends State<Cars> {

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
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddCar()));
          /*showModalBottomSheet<void>(
              context: context,
              isDismissible: true,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Container(
                    color: Colors.white30,
                    height: MediaQuery.of(context).size.height,
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
                                height: 10,
                              ),
                              inputWidget(
                                  context, 'Licence', Icons.numbers, modelC,
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
                              inputWidget(
                                  context, 'Brand', Icons.star, brandC,
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
                                  context, 'Gearbox', Icons.roundabout_right,
                                  colorC, (String? input) {
                                if (input!.isEmpty) {
                                  return 'Please enter car\'s gearbox';
                                }
                                return null;
                              }),
                              const SizedBox(
                                height: 10,
                              ),
                              inputWidget(
                                  context, 'Color', Icons.color_lens_rounded,
                                  colorC, (String? input) {
                                if (input!.isEmpty) {
                                  return 'Please enter car\'s color';
                                }
                                return null;
                              }),
                              const SizedBox(
                                height: 10,
                              ),
                              inputWidget(
                                  context, 'Seat', Icons.event_seat,
                                  colorC, (String? input) {
                                if (input!.isEmpty) {
                                  return 'Please enter car\'s seat';
                                }
                                return null;
                              }),
                              const SizedBox(
                                height: 10,
                              ),
                              inputWidget(
                                  context, 'Top Speed', Icons.speed,
                                  colorC, (String? input) {
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
                                  colorC, (String? input) {
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
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                    ),
                  ),
                );
              });*/
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
