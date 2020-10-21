import 'package:flutter/material.dart';

class Guest extends StatefulWidget {
  @override
  _GuestState createState() => _GuestState();
}

class _GuestState extends State<Guest> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Halo Guest'),
      ),
    );
  }
}
