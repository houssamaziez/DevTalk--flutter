import 'package:f3/home%20ds/Screenhome.dart';
import 'package:f3/home%20ds/profile/dclrion.dart';
import 'package:f3/home%20ds/profile/profilz.dart';
import 'package:f3/scaffold/MyScaffold.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatefulWidget {
  final Function closeDrawer;
  final Color colorb;
  final Color colorw;
  final String imaglang;
  final String namelan;

  CustomDrawer({
    this.closeDrawer,
    this.colorb,
    this.colorw,
    this.imaglang,
    this.namelan,
  });

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return SingleChildScrollView(
      child: Container(
        color: widget.colorb,
        width: mediaQuery.size.width * 0.60,
        height: mediaQuery.size.height,
        child: Column(
          children: <Widget>[
            Container(
                width: double.infinity,
                height: 200,
                color: Colors.grey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.network(
                      widget.imaglang,
                      width: 120,
                      height: 120,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("welcome to ${widget.namelan}")
                  ],
                )),
            ListTile(
              onTap: () {
                final useruid = FirebaseAuth.instance.currentUser.uid;
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => MyProfile(
                      widget.colorb,
                      widget.colorw,
                      useruid,
                      true,
                      false,
                    ),
                  ),
                );
              },
              leading: Icon(Icons.person, color: widget.colorw),
              title: Text(
                "Edit Profil",
                style: TextStyle(color: widget.colorw),
              ),
            ),
            Divider(
              height: 1,
              color: Colors.grey,
            ),
            ListTile(
              onTap: () {
                setState(() {
                  nightsstay = !nightsstay;
                });
                if (nightsstay == true) {
                  chngecolorb = chngecolorw;
                  chngecolorw = Colors.black;
                  post = Color(0xFFF4F4F4);
                }
                if (nightsstay == false) {
                  chngecolorw = Colors.white;
                  chngecolorb = Color(0xFF191919);
                  post = Color(0xFF4D4B4B);
                }
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        MyHome(widget.namelan, widget.imaglang),
                  ),
                );
              },
              leading: IconButton(
                  icon: nightsstay == true
                      ? Icon(Icons.nights_stay_outlined)
                      : Icon(Icons.wb_sunny),
                  color: chngecolorw,
                  onPressed: () {
                    setState(() {
                      nightsstay = !nightsstay;
                    });
                    if (nightsstay == true) {
                      chngecolorb = chngecolorw;
                      chngecolorw = Colors.black;
                      post = Color(0xFFF4F4F4);
                    }
                    if (nightsstay == false) {
                      chngecolorw = Colors.white;
                      chngecolorb = Color(0xFF3B3B3B);
                      post = Color(0xFF4D4B4B);
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            MyHome(widget.namelan, widget.imaglang),
                      ),
                    );
                  }),
              title: Text(
                "Mode",
                style: TextStyle(color: widget.colorw),
              ),
            ),
            Divider(
              height: 1,
              color: Colors.grey,
            ),
            ListTile(
              onTap: () async {
                var sevlng = await SharedPreferences.getInstance();
                sevlng.clear();
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => MyScaffold(),
                  ),
                );
              },
              leading: Icon(Icons.redeem, color: widget.colorw),
              title: Text(
                "Change Field",
                style: TextStyle(color: widget.colorw),
              ),
            ),
            Divider(
              height: 1,
              color: Colors.grey,
            ),
            ListTile(
              onTap: () async {
                var sevlng = await SharedPreferences.getInstance();
                print(sevlng.getString("lang"));
              },
              leading: Icon(Icons.save_sharp, color: widget.colorw),
              title: Text(
                "save post ",
                style: TextStyle(color: widget.colorw),
              ),
            ),
            Divider(
              height: 1,
              color: Colors.grey,
            ),
            ListTile(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("logout !"),
                      content: Container(
                        child: Text(" Would you like to get out ?‏"),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                              Navigator.pop(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      MyScaffold(),
                                ),
                              );
                              Navigator.of(context).pop();
                            },
                            child: Text("confirm")),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Cancel"))
                      ],
                    );
                  },
                );
              },
              leading: Icon(Icons.exit_to_app, color: widget.colorw),
              title: Text(
                "Log Out",
                style: TextStyle(color: widget.colorw),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
