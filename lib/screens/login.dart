import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/app_back.svg',
                      fit: BoxFit.fitHeight,
                    ),
                    Text(
                      'Rent A Car',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
              Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(left: 20),
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        'Rent A Car',
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.blueGrey, fontSize: 18),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Rent A Car',
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.blueGrey, fontSize: 28),
                      ),
                    ],
                  )),
            ],
          )),
    );
  }
}
