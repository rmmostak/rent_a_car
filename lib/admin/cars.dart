import 'package:flutter/material.dart';

class Cars extends StatefulWidget {
  const Cars({Key? key}) : super(key: key);

  @override
  State<Cars> createState() => _CarsState();
}

class _CarsState extends State<Cars> {
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
          // Add your onPressed code here!
        },
        backgroundColor: Colors.blueGrey.shade900,
        child: const Icon(Icons.add),
      ),
    );
  }
}
