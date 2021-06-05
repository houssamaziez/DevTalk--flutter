import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f3/home%20ds/sdcam.dart';

import 'package:flutter/material.dart';

bool isjame = true;

ondelete(id, lang) async {
  await FirebaseFirestore.instance
      .collection("msages")
      .doc("lang")
      .collection(lang)
      .doc("msg")
      .collection('msg')
      .doc(id)
      .delete();
}

ondeletepubl(id, lang) async {
  await FirebaseFirestore.instance
      .collection("msages")
      .doc("lang")
      .collection(lang)
      .doc("publc")
      .collection('publc')
      .doc(id)
      .delete();
}

Future<void> onButtonPressed(context, lang) async {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Color(0xFF737373),
          child: Container(
            child: Myspublc(lang),
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(10),
                topRight: const Radius.circular(10),
              ),
            ),
          ),
        );
      });
}
