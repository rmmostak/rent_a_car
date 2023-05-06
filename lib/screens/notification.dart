import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(15),
        child: Text('This is Notification',
        style: Theme.of(context).textTheme.headline4,),
      ),
    );
  }
}
