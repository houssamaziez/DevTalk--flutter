import 'package:f3/login/language.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../login/Screenlogin.dart';

class MyScaffold extends StatefulWidget {
  @override
  _MyScaffoldState createState() => _MyScaffoldState();
}

class _MyScaffoldState extends State<MyScaffold> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xFF3B3B3B),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Transform.rotate(
                  origin: Offset(30, -60),
                  angle: 2.4,
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 75,
                      top: 40,
                    ),
                    height: 400,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80),
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        colors: [Color(0xFF6D6D6D), Color(0xFF4D4B4B)],
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Expanded(
                      child: Container(
                        child: StreamBuilder(
                          stream: FirebaseAuth.instance.authStateChanges(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return MyHomePage();
                            } else {
                              return ScreenLogin();
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
