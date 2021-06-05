import 'package:flutter/material.dart';
import 'home_icon_buttoms.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 25,
                      ),
                      Text(
                        'DevTalk‏',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Choose the group you want to know and\n share your information in it ',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Expanded(
                    child: GridView.count(
                      // Create a grid with 2 columns. If you change the scrollDirection to
                      // horizontal, this produces 2 rows.
                      crossAxisCount: 3,
                      // Generate 100 widgets that display their index in the List.
                      children: List.generate(filiere.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: CatigoryW(
                            lang: filiere[index]["name filier"],
                            image: filiere[index]["urlimag"],
                            text: filiere[index]["name filier"],
                            color: filiere[index]["color"],
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<Map<String, Object>> filiere = [
    {
      "name filier": "flutter",
      "color": Color(0xFF1095DC),
      "urlimag":
          'https://rainbowapps.io/static/flutter-f83c554c25111514886a18cff724fda0.png',
    },
    {
      "name filier": "html & css",
      "color": Color(0xFFDB6821),
      "urlimag":
          'http://config2print.com/wp-content/uploads/2016/08/Logo-HTML5-CSS3-200.png',
    },
    {
      "name filier": "java",
      "color": Color(0xFFE6F0F7),
      "urlimag":
          'https://cdn.iconscout.com/icon/free/png-512/java-43-569305.png',
    },
    {
      "name filier": "algorithme",
      "color": Color(0xFFBB5FFC),
      "urlimag": 'https://image.flaticon.com/icons/png/512/2172/2172917.png',
    },
    {
      "name filier": "c",
      "color": Color(0xFFE2FC5F),
      "urlimag": 'https://img.icons8.com/color/452/c-programming.png',
    },
    {
      "name filier": "c++",
      "color": Color(0xFFDEE3C7),
      "urlimag":
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/18/ISO_C%2B%2B_Logo.svg/306px-ISO_C%2B%2B_Logo.svg.png',
    },
    {
      "name filier": "c#",
      "color": Color(0xFF34F0CE),
      "urlimag": 'https://img.icons8.com/ios/452/c-sharp-logo.png',
    },
    {
      "name filier": "php",
      "color": Color(0xFFBDF7B2),
      "urlimag": 'https://pngimg.com/uploads/php/php_PNG39.png',
    },
    {
      "name filier": "mysql",
      "color": Color(0xFF34F0CE),
      "urlimag": 'https://www.erwanfeltesse.fr/media/mysql.png',
    },
    {
      "name filier": "xml",
      "color": Color(0xFFBDF7B2),
      "urlimag": 'https://image.flaticon.com/icons/png/512/136/136444.png',
    },
    {
      "name filier": "json ",
      "color": Color(0xFF34F0CE),
      "urlimag": 'https://img.icons8.com/fluent-systems-regular/452/json.png',
    },
    {
      "name filier": "Firebase",
      "color": Color(0xFFF7F4B2),
      "urlimag":
          'https://seeklogo.com/images/F/firebase-logo-402F407EE0-seeklogo.com.png',
    }
  ];
}
