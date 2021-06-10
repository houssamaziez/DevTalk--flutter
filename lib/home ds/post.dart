import 'package:f3/home%20ds/profile/profilz.dart';
import 'package:f3/home%20ds/sdmsg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import 'fuction.dart';

Column masseg(lang, buildStreamBuilder, colorwait, colorblack, isnight) {
  return Column(
    children: [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0), color: colorblack),
            child: buildStreamBuilder(),
          ),
        ),
      ),
      Mysdmsg(
        lang,
        colorblack,
        colorwait,
      ),
    ],
  );
}

class Post extends StatelessWidget {
  final iduser;
  final colorwht, colorblck, postcolor;
  final docc;
  final index;
  final lang;
  final contexn;
  final user;

  Post(this.docc, this.index, this.lang, this.contexn, this.user, this.colorwht,
      this.colorblck, this.postcolor, this.iduser);
  @override
  Widget build(BuildContext context) {
    return pokst(docc, index, lang, contexn, user);
  }

  pokst(docc, int index, lang, context, user) {
    final userrr = FirebaseAuth.instance.currentUser;
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 4, left: 7, right: 7),
              child: Card(
                color: postcolor,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15)),
                ),
                child: ListTile(
                  subtitle: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8),
                                          bottomRight: Radius.circular(8),
                                          bottomLeft: Radius.circular(8)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text(
                                        docc[index]["msg"],
                                        style: TextStyle(
                                          color: colorwht,
                                        ),
                                      ),
                                    ))),
                          ],
                        ),
                        Divider(
                          thickness: 2,
                          color: colorwht,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  IconButton(
                                      icon: Icon(
                                        Icons.save,
                                        color: colorwht,
                                      ),
                                      onPressed: () {}),
                                  Text(
                                    'save',
                                    style: TextStyle(color: colorwht),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.comment,
                                    color: colorwht,
                                    size: 30,
                                  ),
                                  Text(
                                    'Comment',
                                    style: TextStyle(color: colorwht),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {},
                                child: Row(
                                  children: [
                                    IconButton(
                                        icon: Icon(
                                          Icons.star,
                                          color: isjame ? Colors.red : colorwht,
                                        ),
                                        onPressed: () async {
                                          isjame = !isjame;
                                          if (isjame == true) {
                                            await user
                                                .doc(docc[index].id)
                                                .update({
                                              "like": docc[index]["like"] + 1
                                            });
                                          }
                                          if (isjame == false) {
                                            await user
                                                .doc(docc[index].id)
                                                .update({
                                              "like": docc[index]["like"] - 1
                                            });
                                          }
                                        }),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Like' + docc[index]["like"].toString(),
                                      style: TextStyle(color: colorwht),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  title: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        MyProfile(colorblck, colorwht,
                                            docc[index]["id"], false),
                                  ),
                                );
                              },
                              child: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(docc[index]["urlimg"]),
                                radius: 24,
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    docc[index]["iduser"],
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: colorwht,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    docc[index]["date"].toString(),
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: colorwht,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            if (docc[index]["id"] == userrr.uid)
                              DropdownButton(
                                hint: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 35, top: 20),
                                  child: Text(
                                    "mode_edit",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: colorwht,
                                    ),
                                  ),
                                ),
                                underline: Container(),
                                onChanged: (_value) {
                                  if (_value == "delet post") {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("delete post !"),
                                          content: Container(
                                            child: Text(
                                                " Would you like to delete post ?‏"),
                                          ),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  ondeletepubl(
                                                      docc[index].id, lang);
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text("delete "))
                                          ],
                                        );
                                      },
                                    );
                                  }
                                },
                                items: [
                                  DropdownMenuItem(
                                    value: "delet post",
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.delete,
                                        ),
                                        Text("delet post")
                                      ],
                                    ),
                                  ),
                                ],
                                icon: Icon(
                                  Icons.mode_edit,
                                  color: colorwht,
                                ),
                              ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15)),
                              color: postcolor),
                          height: 230,
                          child: PhotoView(
                            backgroundDecoration:
                                BoxDecoration(color: Colors.transparent),
                            imageProvider:
                                NetworkImage(docc[index]["urlimgpubl"]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
