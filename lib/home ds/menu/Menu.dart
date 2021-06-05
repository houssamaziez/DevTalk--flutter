import 'package:f3/scaffold/MyScaffold.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
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
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return SingleChildScrollView(
      child: Container(
        color: colorb,
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
                      imaglang,
                      width: 120,
                      height: 120,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("welcome to $namelan")
                  ],
                )),
            ListTile(
              onTap: () {
                debugPrint("Tapped Profile");
              },
              leading: Icon(Icons.person, color: colorw),
              title: Text(
                "Your Profile",
                style: TextStyle(color: colorw),
              ),
            ),
            Divider(
              height: 1,
              color: Colors.grey,
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.settings, color: colorw),
              title: Text(
                "Settings",
                style: TextStyle(color: colorw),
              ),
            ),
            Divider(
              height: 1,
              color: Colors.grey,
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => MyScaffold(),
                  ),
                );
              },
              leading: Icon(Icons.redeem, color: colorw),
              title: Text(
                "change filiare",
                style: TextStyle(color: colorw),
              ),
            ),
            Divider(
              height: 1,
              color: Colors.grey,
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.save_sharp, color: colorw),
              title: Text(
                "save post ",
                style: TextStyle(color: colorw),
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
              leading: Icon(Icons.exit_to_app, color: colorw),
              title: Text(
                "Log Out",
                style: TextStyle(color: colorw),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
