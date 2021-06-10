import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f3/home%20ds/post.dart';
import 'package:f3/home%20ds/profile/dclrion.dart';
import 'package:f3/home%20ds/profile/profilz.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foldable_sidebar/foldable_sidebar.dart';

import 'fuction.dart';
import 'menu/Menu.dart';

class MyHome extends StatefulWidget {
  final lang, imaglang;

  const MyHome(this.lang, this.imaglang);
  @override
  _MyHomeState createState() => _MyHomeState(lang, imaglang);
}

class _MyHomeState extends State<MyHome> {
  final String imaglang;

  final String lang;
  FSBStatus drawerStatus;

  _MyHomeState(this.lang, this.imaglang);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 2,
      length: 3,
      child: Scaffold(
        backgroundColor: chngecolorb,
        appBar: AppBar(
          leading: IconButton(
            color: chngecolorw,
            icon: Icon(Icons.menu),
            onPressed: () {
              setState(() {
                drawerStatus = drawerStatus == FSBStatus.FSB_OPEN
                    ? FSBStatus.FSB_CLOSE
                    : FSBStatus.FSB_OPEN;
              });
            },
          ),
          backgroundColor: chngecolorb,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                ' DevTalk ',
                style: TextStyle(
                  color: chngecolorw,
                  fontSize: 30,
                ),
              ),
            ),
            SizedBox(
              width: 70,
            ),
          ],
          bottom: TabBar(
            onTap: (index) {
              setState(() {
                drawerStatus = drawerStatus == FSBStatus.FSB_OPEN
                    ? FSBStatus.FSB_CLOSE
                    : FSBStatus.FSB_CLOSE;
              });
            },
            indicatorColor: chngecolorw,
            tabs: [
              Tab(
                icon: Icon(
                  Icons.person,
                  color: chngecolorw,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.message,
                  color: chngecolorw,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.home,
                  color: chngecolorw,
                ),
              ),
            ],
          ),
        ),
        body: FoldableSidebarBuilder(
          drawer: CustomDrawer(
            closeDrawer: () {
              setState(() {
                drawerStatus = FSBStatus.FSB_CLOSE;
              });
            },
            colorb: chngecolorb,
            colorw: chngecolorw,
            imaglang: imaglang,
            namelan: lang,
          ),
          screenContents: buildTabBarView(),
          status: drawerStatus,
        ),
      ),
    );
  }

  TabBarView buildTabBarView() {
    return TabBarView(
      children: [
        MyProfile(chngecolorb, chngecolorw,
            FirebaseAuth.instance.currentUser.uid, false, true),
        messageview(),
        screenHome(),
      ],
    );
  }

  Scaffold screenHome() {
    return Scaffold(
      backgroundColor: chngecolorb,
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.post_add),
        label: Text("add post"),
        backgroundColor: Color(0xFF727272),
        onPressed: () {
          onButtonPressed(context, lang);
        },
        tooltip: 'Increment',
      ),
      body: Column(
        children: [
          story(),
          SizedBox(
            height: 10,
          ),
          publc()
        ],
      ),
    );
  }

  Column messageview() {
    return masseg(lang, screenmessage, chngecolorw, chngecolorb, nightsstay);
  }

  Widget story() {
    return Container(
      height: 70,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("hsmm").snapshots(),
        builder: (context, snapshost) {
          if (snapshost.connectionState == ConnectionState.waiting) {
            return Center(
              child: null,
            );
          }
          final doccs = snapshost.data.docs;
          return ListView.builder(
            itemCount: doccs.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return StreamBuilder(builder: (context, snpch) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => MyProfile(
                          chngecolorb,
                          chngecolorw,
                          doccs[index].id,
                          false,
                          false,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 45,
                      child: CircleAvatar(
                        backgroundColor: chngecolorb,
                        radius: 28,
                        backgroundImage: NetworkImage(
                          doccs[index]["urlimag"],
                        ),
                      ),
                    ),
                  ),
                );
              });
            },
          );
        },
      ),
    );
  }

  bool ismsg = false;
  screenmessage() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("msages")
          .doc("lang")
          .collection(lang)
          .doc("msg")
          .collection('msg')
          .orderBy('date', descending: true)
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

        final docc = snapshot.data.docs;
        final userrr = FirebaseAuth.instance.currentUser;

        return ListView.builder(
          reverse: true,
          itemCount: docc.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (docc[index]["id"] != userrr.uid)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (docc[index]["id"] != userrr.uid)
                          Padding(
                            padding: const EdgeInsets.only(left: 50, top: 20),
                            child: Text(
                              docc[index]["iduser"],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: chngecolorw,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                Row(
                  mainAxisAlignment:
                      // ignore: unrelated_type_equality_checks
                      docc[index]["id"] != userrr.uid
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.end,
                  children: [
                    if (docc[index]["id"] != userrr.uid)
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => MyProfile(
                                chngecolorb,
                                chngecolorw,
                                docc[index]["id"],
                                false,
                                false,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              docc[index]["urlimg"],
                            ),
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, bottom: 10.0),
                      child: InkWell(
                        onLongPress: docc[index]["id"] == userrr.uid
                            ? () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Delete Message"),
                                      content: Container(
                                        child: Text(
                                            "Are you sure you wanna delete this message ?‏"),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              ondelete(docc[index].id, lang);
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("Delete"))
                                      ],
                                    );
                                  },
                                );
                              }
                            : null,
                        child: Container(
                          width: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment:
                                  docc[index]["id"] != userrr.uid
                                      ? CrossAxisAlignment.start
                                      : CrossAxisAlignment.end,
                              children: [
                                docc[index]["isphoto"] == "false"
                                    ? docc[index]["msg"] != null
                                        ? Text(
                                            docc[index]["msg"],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17),
                                          )
                                        : Container()
                                    : docc[index]["msgphoto"] != null
                                        ? Image(
                                            image: NetworkImage(
                                              docc[index]["msgphoto"],
                                            ),
                                          )
                                        : Container(),
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(15),
                                  bottomRight: docc[index]["id"] != userrr.uid
                                      ? Radius.circular(15)
                                      : Radius.circular(0),
                                  bottomLeft: docc[index]["id"] != userrr.uid
                                      ? Radius.circular(0)
                                      : Radius.circular(15)),
                              color: docc[index]["id"] != userrr.uid
                                  ? Color(0xFF4694F9)
                                  : Color(0xFF939B9F)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  publc() {
    CollectionReference<Map<String, dynamic>> user = FirebaseFirestore.instance
        .collection("msages")
        .doc("lang")
        .collection(lang)
        .doc("publc")
        .collection('publc');

    return StreamBuilder(
      stream: user.orderBy('date', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: const EdgeInsets.only(top: 180),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
              backgroundColor: Colors.black,
            ),
          );
        }

        final docc = snapshot.data.docs;
        var userrr = FirebaseAuth.instance.currentUser;

        return Expanded(
          child: Container(
            color: chngecolorb,
            child: RefreshIndicator(
              color: Colors.red,
              onRefresh: () async {
                Future.delayed(Duration(seconds: 2));
                setState(() {
                  chngecolorw = chngecolorw;
                });
              },
              child: ListView.builder(
                itemCount: docc.length,
                itemBuilder: (BuildContext context, int index) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomLeft,
                              colors: [chngecolorb, chngecolorb],
                            ),
                          ),
                          child: Center(
                              child: Post(docc, index, lang, context, user,
                                  chngecolorw, chngecolorb, post, userrr.uid)),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
