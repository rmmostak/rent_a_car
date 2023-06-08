import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'availablity.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
                    'Profile',
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
    );
  }
}
