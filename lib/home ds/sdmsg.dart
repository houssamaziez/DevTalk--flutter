import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class Mysdmsg extends StatefulWidget {
  final String lang;
  final Color colorb;
  final Color colorw;

  Mysdmsg(
    this.lang,
    this.colorb,
    this.colorw,
  );

  @override
  _MysdmsgState createState() => _MysdmsgState(colorb, colorw);
}

class _MysdmsgState extends State<Mysdmsg> {
  final Color colorb;
  final Color colorw;
  String a, isphoto = "false", msgphoto = "image is null";

  DateTime now = DateTime.now();

  _MysdmsgState(this.colorb, this.colorw);
  gotocam() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Expanded(
            child: Container(
              color: Color(0xFFCAC3C3),
              child: Row(
                children: [
                  Spacer(),
                  IconButton(
                      color: widget.colorw,
                      icon: Icon(
                        Icons.add_photo_alternate_sharp,
                        color: colorw,
                      ),
                      onPressed: () {
                        getcamr(ImageSource.gallery);
                        Navigator.of(context).pop();
                      }),
                  IconButton(
                      color: widget.colorw,
                      icon: Icon(
                        Icons.add_a_photo,
                        color: colorw,
                      ),
                      onPressed: () {
                        getcamr(ImageSource.camera);
                        Navigator.of(context).pop();
                      }),
                  Spacer(),
                  if (imagepht != null)
                    IconButton(
                        color: widget.colorw,
                        icon: Icon(
                          Icons.cancel_rounded,
                          color: colorw,
                        ),
                        onPressed: () {
                          setState(() {
                            Navigator.of(context).pop();
                          });
                        }),
                ],
              ),
            ),
          );
        });
  }

  _sendmsg(String msgg, imagepathh, msgphotoo) async {
    if (imagepathh != null) {
      final ref = FirebaseStorage.instance
          .ref()
          .child("user_imag")
          .child(DateTime.now().toString() + '.jpg');
      await ref.putFile(imagepathh);
      msgphotoo = await ref.getDownloadURL();
    } else {
      msgphotoo = null;
    }

    final userrr = FirebaseAuth.instance.currentUser;
    final userdoc = await FirebaseFirestore.instance
        .collection("hsmm")
        .doc(userrr.uid)
        .get();
    await FirebaseFirestore.instance
        .collection("msages")
        .doc("lang")
        .collection(widget.lang)
        .doc("msg")
        .collection('msg')
        .add(
      {
        "msg": msgg,
        "date": DateTime.now(),
        "iduser": userdoc["user name"],
        "urlimg": userdoc["urlimag"],
        "id": userrr.uid,
        "lang": widget.lang,
        "isphoto": isphoto,
        "msgphoto": msgphotoo,
      },
    );

    userdoc.data().clear();
  }

  final GlobalKey<FormState> ky = GlobalKey<FormState>();

  var _contrltext = TextEditingController();

  final imagePicker = ImagePicker();
  File imagepht;

  Future getcamr(cam) async {
    final pikfil = await imagePicker.getImage(
      source: cam,
    );

    if (pikfil != null) {
      setState(() {
        imagepht = File(pikfil.path);
        isphoto = "true";
      });
    } else {
      print("no image silact");
    }
  }

  String _msgg;

  bool msvid = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.colorb,
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (imagepht != null) Spacer(),
            if (imagepht != null)
              SizedBox(
                width: 40,
              ),
            imagepht == null
                ? IconButton(
                    color: widget.colorw,
                    icon: Icon(Icons.add_photo_alternate),
                    onPressed: () {
                      gotocam();
                    })
                : Column(
                    children: [
                      InkWell(
                        onTap: () {
                          gotocam();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 100,
                              child: Image.file(imagepht),
                            ),
                          ],
                        ),
                      ),
                      if (imagepht != null)
                        IconButton(
                          onPressed: () {
                            setState(() {
                              imagepht = null;
                            });
                          },
                          icon: Icon(Icons.cancel_rounded),
                        ),
                    ],
                  ),
            if (imagepht == null)
              Expanded(
                  child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: widget.colorw),
                  ),
                ),
                controller: _contrltext,
                onChanged: (val) {
                  _msgg = val;
                },
              )),
            if (imagepht != null) Spacer(),
            IconButton(
                color: widget.colorw,
                icon: Icon(Icons.send),
                onPressed: () {
                  if (_msgg == null && imagepht == null) {
                    return;
                  }

                  if (_msgg != null || imagepht != null) {
                    if (imagepht != null) {
                      setState(() {
                        isphoto = "true";
                      });
                    }
                    if (imagepht == null) {
                      setState(() {
                        isphoto = "false";
                      });
                    }
                    _sendmsg(_msgg, imagepht, msgphoto);
                    _msgg = null;
                    setState(() {
                      msgphoto = null;
                      imagepht = null;
                    });
                  }

                  _contrltext.clear();
                }),
          ],
        ),
      ),
    );
  }
}
