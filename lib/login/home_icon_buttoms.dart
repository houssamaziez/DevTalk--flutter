import 'package:f3/home%20ds/Screenhome.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CatigoryW extends StatefulWidget {
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
  _CatigoryWState createState() => _CatigoryWState();
}

class _CatigoryWState extends State<CatigoryW> {
  getlang() async {
    var sevlng = await SharedPreferences.getInstance();
    var language = sevlng.getString("lang");
    if (language != null) {
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => MyHome(
            sevlng.getString("lang"),
            sevlng.getString("image"),
          ),
        ),
      );
    }
  }

  sevlang(String lang, image) async {
    var sevlng = await SharedPreferences.getInstance();
    sevlng.setString("lang", lang);
    sevlng.setString("image", image);
  }

  @override
  void initState() {
    getlang();

    super.initState();
  }

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
                backgroundColor: widget.color,
                child: Image.network(
                  widget.image,
                ),
              ),
            ),
            Spacer(),
            Text(
              widget.text,
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
      onTap: () async {
        var sevlng = await SharedPreferences.getInstance();

        if (sevlng.getString("lang") == null) {
          sevlang(
            widget.lang,
            widget.image,
          );
          print(sevlng.getString("lang"));
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => MyHome(
                widget.lang,
                widget.image,
              ),
            ),
          );
        }
      },
    );
  }
}
