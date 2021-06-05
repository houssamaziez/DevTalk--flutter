import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class Myspublc extends StatefulWidget {
  final String lang;

  const Myspublc(this.lang);
  @override
  _MysdmsgState createState() => _MysdmsgState(lang);
}

class _MysdmsgState extends State<Myspublc> {
  final String lang;
  bool isimag = false;
  String a;
  _MysdmsgState(this.lang);
  _sendmsg(String msgg) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child("user_imag")
        .child(DateTime.now().toString() + '.jpg');
    await ref.putFile(imagepht);
    final userrr = FirebaseAuth.instance.currentUser;
    final userdoc = await FirebaseFirestore.instance
        .collection("hsmm")
        .doc(userrr.uid)
        .get();
    DateTime now = DateTime.now();

    await FirebaseFirestore.instance
        .collection("msages")
        .doc("lang")
        .collection(lang)
        .doc("publc")
        .collection('publc')
        .add(
      {
        "msg": msgg,
        "date": DateFormat('yyyy-MM-dd – kk:mm').format(now),
        "iduser": userdoc["user name"],
        "urlimg": userdoc["urlimag"],
        "id": userrr.uid,
        "urlimgpubl": await ref.getDownloadURL(),
      },
    );
    userdoc.data().clear();
  }

  File imagepht;
  final GlobalKey<FormState> ky = GlobalKey<FormState>();
  var _contrltext = TextEditingController();
  final imagePicker = ImagePicker();
  Future getcamr() async {
    final pikfil = await imagePicker.getImage(
      source: ImageSource.gallery,
    );

    setState(() {
      if (pikfil != null) {
        imagepht = File(pikfil.path);
      } else {
        print("no image silact");
      }
    });
  }

  String _msgg;
  bool msvid = true;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Color(0xFFECE9E9),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      color: Colors.black,
                      icon: Icon(Icons.add_photo_alternate),
                      onPressed: () {
                        getcamr();
                      }),
                  Expanded(
                      child: TextField(
                    maxLines: 5,
                    minLines: 1,
                    decoration: InputDecoration(
                      hintText: 'write enything',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    controller: _contrltext,
                    onChanged: (val) {
                      _msgg = val;
                    },
                  )),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
              imagepht == null
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 150,
                            child: Image.file(imagepht),
                          ),
                        ],
                      ),
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      if (imagepht == null) {
                        return;
                      }
                      if (_msgg == null) {
                        _msgg = '...';
                      }

                      if (_msgg != null) {
                        _sendmsg(_msgg);
                        setState(() {
                          imagepht = null;
                          _msgg = null;
                        });
                        Navigator.of(context).pop();
                      }

                      _contrltext.clear();
                    },
                    child: Text(
                      "Post",
                      style: TextStyle(fontSize: 22, color: Colors.black),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
