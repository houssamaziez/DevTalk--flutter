import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: 
      Scaffold(
        body:
        Column(
          children: [
            SizedBox(height: 20,),
            Expanded(child: Container(color: Colors.white,
             child: Row(
               children:[
                 IconButton(onPressed: (){}, icon: Icon(Icons.chevron_left , size: 50,)),
                 Spacer(),
                 Padding(
                   padding: const EdgeInsets.fromLTRB(15, 35, 50, 20),
                   child: Text("My profil" , style: TextStyle(fontSize: 33 ,fontWeight: FontWeight.bold),),
                 ),
                 Spacer(),
               ],
             )
            ,
            )),
            Expanded(child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    SizedBox(height: 20,),
                    Stack( 
                      children: [
                        CircleAvatar(radius: 80, backgroundImage: NetworkImage("https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-with-glasses.jpg"),),
                        Padding( 
                          padding: const EdgeInsets.only(left: 119,top: 110  ),  
                          child: IconButton(onPressed: (){}, icon: Icon(Icons.edit , size: 35, color:Colors.grey),
                        )
                        )],
                    ),
                    SizedBox(height: 20,), 
                  Text("QiTooo" ,style: TextStyle(fontWeight: FontWeight.bold , fontSize: 30),)
                  ], 
                ) 
              ],
            ),
            ),flex: 3, 
            
            ),
            Expanded(child: Container(
              child: 
              Column(
                children: [
                  ListTile(
                   title: Text("Name  ",style: TextStyle( fontSize: 25 , fontWeight: FontWeight.bold),) , 
                   subtitle: Text("  Belkaid zohra ", style:TextStyle( fontSize: 20),),
                   trailing: Icon(Icons.edit),
                   ),
               Divider(
              height: 1,
              color: Colors.grey,
            ),
                ],
              )
              ,
            )),
            Expanded(child: Container(
              child: 
              Column(
                children: [
                  ListTile(
                   title: Text("Email  ",style: TextStyle( fontSize: 25 , fontWeight: FontWeight.bold),) , 
                   subtitle: Text("  zahrabelkai671@gmail.com ", style:TextStyle( fontSize: 20),),
                   trailing: Icon(Icons.edit),
                   ),
                    Divider(
              height: 1,
              color: Colors.grey,
            ),
                ],
              )
              ,
            )),
            Expanded(child: Container(
              child: 
              Column(
                children: [
                  ListTile(
                   title: Text("specialty  ",style: TextStyle( fontSize: 25 , fontWeight: FontWeight.bold),) , 
                   subtitle: Text("  App mobil developer ", style:TextStyle( fontSize: 20),),
                   trailing: Icon(Icons.edit),
                   ),
                    Divider(
              height: 1,
              color: Colors.grey,
            ),
                ],
              )
              ,
            )),
            Expanded(child: Container(
              child: 
              ListTile(
               title: Text("location  ",style: TextStyle( fontSize: 25 , fontWeight: FontWeight.bold),) , 
               subtitle: Text("  Batna-Algeria ", style:TextStyle( fontSize: 20),),
               trailing: Icon(Icons.edit),
               )
              ,
            )), 
            
          ],
        )
        ,
      )
      ,
      
    );
  }
}