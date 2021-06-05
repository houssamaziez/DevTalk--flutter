import 'package:f3/home%20ds/Screenhome.dart';
import 'package:flutter/material.dart';

class CatigoryW extends StatelessWidget {
  final String image;
  final String text;
  final Color color;
  final String lang;

  CatigoryW({
    this.image,
    this.text,
    this.color,
    this.lang,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            colors: [
              Color(0xFFFDFDFD),
              Color(0x9FEAEAEA),
              Color(0x9FEAE7E7),
            ],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: CircleAvatar(
                backgroundColor: color,
                child: Image.network(
                  image,
                ),
              ),
            ),
            Spacer(),
            Text(
              text,
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => MyHome(lang, image),
          ),
        );
      },
    );
  }
}
