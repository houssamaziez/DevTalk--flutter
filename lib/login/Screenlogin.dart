import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class ScreenLogin extends StatefulWidget {
  String iduser;
  @override
  _ScreenLoginState createState() => _ScreenLoginState(iduser);
}

class _ScreenLoginState extends State<ScreenLogin> {
  // __________________________DECLARATION _________________________
  String email = "",
      pass = "",
      username = "",
      urlimag = "",
      msgpass = 'The password provided is too weak.',
      iduser,
      msgerr = " Error with Email and Password";
  bool islogin = true, islozddin = false, passtrue = true, isimag = false;
  final GlobalKey<FormState> ky = GlobalKey<FormState>();
  File imagepht;
  final imagePicker = ImagePicker();

  _ScreenLoginState(this.iduser);

  // __________________________function create Account _________________________
  //
  regjitster(
    String _email,
    String _password,
  ) async {
    try {
      setState(() {
        islozddin = true;
      });

      UserCredential userCredential;
      userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );

      CollectionReference user;
      user = FirebaseFirestore.instance.collection('hsmm');
      final ref = FirebaseStorage.instance
          .ref()
          .child("user_imag")
          .child(userCredential.user.uid + '.jpg');
      await ref.putFile(imagepht);

      user.doc(userCredential.user.uid).set({
        'email': email,
        'password': pass,
        'user name': username,
        'urlimag': "${await ref.getDownloadURL()}"
      });
      iduser = userCredential.user.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        passtrue = false;
        islozddin = false;
        msgerr = 'weak-password';
      } else if (e.code == 'email-already-in-use') {
        msgerr = 'The account already exists for that email.';
      }
      setState(() {
        islozddin = false;
      });
    } catch (e) {
      setState(() {
        islozddin = false;
      });
      print(e);
    }
  }

  // __________________________function LOGIN _________________________
  login(String _email, String _password) async {
    try {
      // ignore: unused_local_variable
      UserCredential userCredential;
      setState(() {
        islozddin = true;
      });
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      islozddin = false;
      if (e.code == 'user-not-found') {
        passtrue = false;
        msgerr = "'user-not-found'";

        print('________user-not-found____________');
      } else if (e.code == 'wrong-password') {
        print('________Wrong password provided for that user.____________');
        msgerr = 'Wrong password provided for that user';
      }
      setState(() {
        islozddin = false;
      });
    } catch (e) {
      setState(() {
        islozddin = false;
      });
      print(e);
    }
  }

  //_____________________________ camra function_________________
  Future getcamr() async {
    final pikfil = await imagePicker.getImage(
      source: ImageSource.gallery,
      imageQuality: 20,
    );

    if (pikfil != null) {
      isimag = true;
    }

    setState(() {
      if (pikfil != null) {
        imagepht = File(pikfil.path);
      } else {
        print("no image silact");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 2),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //____________________________text login and sing up _____________________

              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Card(
                      elevation: 0,
                      color: Colors.transparent,
                      child: Form(
                        key: ky,
                        child: Column(
                          children: [
                            //__________________________________ camra_____________________
                            Camra(),
                            //__________________________________ TEXT Email_____________________
                            TextEmail(),
                            // __________________________textFromfiled password _________________________
                            Fromfiledpassword(),
                            // __________________________textFromfiled user name_________________________
                            if (islogin == false) UserName(),
                          ],
                        ),
                      )),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              //____________________________text login and sing up _____________________

              if (islozddin) CircularProgressIndicator(),
              if (!islozddin) LoginAndSingUp(context),
              islogin == false
                  ? TextButton(
                      onPressed: () {
                        setState(() {
                          islogin = !islogin;
                        });
                      },
                      child: Text(" Login"))
                  : TextButton(
                      onPressed: () {
                        setState(() {
                          islogin = !islogin;
                        });
                      },
                      child: Text(" create Account")),

              // __________________________button login ,sing up _________________________
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Padding UserName() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 40),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Color(0xFFCFCACA).withOpacity(0.4),
        ),
        child: TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.amber,
                ),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            labelText: "User name",
            hintText: 'User name',
            hintStyle: TextStyle(color: Colors.white),
            prefixIcon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.white,
            ),
          ),
          // ignore: missing_return
          validator: (vlun) {
            if (vlun.isEmpty) {
              return "nume error";
            }
          },
          onSaved: (sv) {
            setState(() {
              username = sv;
            });
          },
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Padding TextEmail() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 25),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Color(0xFFCFCACA).withOpacity(0.4),
        ),
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            labelText: "Email",
            hintText: 'Email',
            hintStyle: TextStyle(color: Colors.white),
            prefixIcon: Icon(
              Icons.email,
              color: Colors.white,
            ),
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.white,
            ),
          ),
          validator: (vlu) {
            if (vlu.isEmpty || !vlu.contains('@')) {
              return ' email error';
            }
            return null;
          },
          onSaved: (sdv) {
            email = sdv;
          },
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Padding Camra() {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Stack(
        children: [
          SizedBox(
            width: 20,
          ),
          CircleAvatar(
            backgroundColor:
                islogin == true ? Colors.transparent : Color(0xFFA1A1AC),
            radius: 36,
            child: CircleAvatar(
              backgroundColor: islogin == true
                  ? Colors.transparent
                  : Color(0xFFCFCACA).withOpacity(0.4),
              backgroundImage: imagepht != null ? FileImage(imagepht) : null,
              radius: 34,
            ),
          ),
          if (islogin != true)
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 37),
              child: IconButton(
                icon: Icon(
                  Icons.add_a_photo,
                  size: 25,
                ),
                onPressed: () {
                  getcamr();
                },
              ),
            )
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Padding LoginAndSingUp(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: ElevatedButton(
        child: islogin == true ? Text("Login") : Text("Sing Up"),
        style: ElevatedButton.styleFrom(
          primary: Color(0xFFFFFFFF).withOpacity(0.4),
          elevation: 20,
          minimumSize: Size(250, 50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        onPressed: () {
          final isval = ky.currentState.validate();

          if (isval) {
            ky.currentState.save();
            if (islogin) {
              login(email, pass);
            } else {
              if (isimag == false) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: Duration(milliseconds: 900),
                    backgroundColor: Colors.red,
                    content: Text("img is vide"),
                  ),
                );
                return;
              }
              regjitster(email, pass);
            }
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: Duration(milliseconds: 3000),
              backgroundColor: Colors.red,
              content: Text("$msgerr"),
            ),
          );
        },
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Padding Fromfiledpassword() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 40),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Color(0xFFCFCACA).withOpacity(0.4),
        ),
        child: TextFormField(
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.amber,
                ),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            labelText: "Password",
            counterStyle: TextStyle(color: Colors.white),
            hintText: 'Password',
            hintStyle: TextStyle(color: Colors.white),
            prefixIcon: Icon(
              Icons.lock,
              color: Color(0xFFFFFFFF),
            ),
            labelStyle: TextStyle(
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          validator: (vlun) {
            if (vlun.isEmpty) {
              return msgpass;
            }
            return null;
          },
          onSaved: (sv) {
            setState(() {
              pass = sv;
            });
          },
        ),
      ),
    );
  }
}
