import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyProfile extends StatelessWidget {
  final colorb;
  final colorw;
  MyProfile(this.colorb, this.colorw, this.userrr, this.isme);

  final userrr;

  final bool isme;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorb,
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('hsmm')
                .doc(userrr)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    backgroundColor: Colors.black,
                  ),
                );
              }

              final docc = snapshot.data;
              return ListView(
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.chevron_left,
                              size: 50, color: colorw)),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 35, 50, 20),
                        child: Row(
                          children: [
                            if (isme == true)
                              Text(
                                "My ",
                                style: TextStyle(fontSize: 33, color: colorw),
                              ),
                            Text(
                              "Profile",
                              style: TextStyle(fontSize: 33, color: colorw),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 74,
                                  backgroundColor: colorw,
                                  child: CircleAvatar(
                                    radius: 70,
                                    backgroundImage: NetworkImage(
                                      docc["urlimag"],
                                    ),
                                  ),
                                ),
                                if (isme == true)
                                  Positioned(
                                      bottom: 10,
                                      right: 10,
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.edit,
                                            size: 35, color: colorw),
                                      ))
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              docc["user name"],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: colorw),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            "Name  ",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: colorw),
                          ),
                          subtitle: Text(
                            docc["user name"],
                            style: TextStyle(fontSize: 20, color: colorw),
                          ),
                          trailing: isme == true
                              ? Icon(Icons.edit, color: colorw)
                              : Text(""),
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            "Email  ",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: colorw),
                          ),
                          subtitle: Text(
                            docc["email"],
                            style: TextStyle(fontSize: 20, color: colorw),
                          ),
                          trailing: isme == true
                              ? Icon(Icons.edit, color: colorw)
                              : Text(""),
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            "specialty  ",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: colorw),
                          ),
                          subtitle: Text(
                            "  App mobil developer ",
                            style: TextStyle(fontSize: 20, color: colorw),
                          ),
                          trailing: isme == true
                              ? Icon(Icons.edit, color: colorw)
                              : Text(""),
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: ListTile(
                      title: Text(
                        "location  ",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: colorw),
                      ),
                      subtitle: Text(
                        "  Batna-Algeria ",
                        style: TextStyle(fontSize: 20, color: colorw),
                      ),
                      trailing: isme == true
                          ? Icon(Icons.edit, color: colorw)
                          : Text(""),
                    ),
                  ),
                ],
              );
            }));
  }
}
