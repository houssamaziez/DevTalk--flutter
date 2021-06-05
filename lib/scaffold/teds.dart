import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class Rmsdd extends StatefulWidget {
  @override
  _RmsddState createState() => _RmsddState();
}

class _RmsddState extends State<Rmsdd> {
  var user = FirebaseFirestore.instance
      .collection("msages")
      .where("lang", isEqualTo: "flutter")
      .where("date", isGreaterThan: DateTime.now());
  gg() async {
    await user.get().then((value) {
      value.docs.forEach((element) {
        print(element["msg"]);
      });
    });
  }

  List ff = [];
  @override
  void initState() {
    print("__________________________");
    gg();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildStreamBuilder(),
    );
  }

  buildStreamBuilder() {
    return StreamBuilder(
      stream: user.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        var docc = snapshot.data.docs;

        return ListView.builder(
          reverse: true,
          itemCount: docc.length,
          itemBuilder: (BuildContext context, int index) {
            return Text(docc[index]["msg"]);
          },
        );
      },
    );
  }
}
