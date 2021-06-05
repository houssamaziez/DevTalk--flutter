import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyProfile extends StatelessWidget {
  Color colorblack;

  MyProfile(this.colorblack);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorblack,
      body: Center(
        child: Text('my profile '),
      ),
    );
  }
}
