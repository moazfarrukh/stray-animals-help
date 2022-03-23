import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'afterlogin.dart';
import 'login.dart';

class splashscreen extends StatefulWidget {
  @override
  _splashscreenState createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  String finalemail = " ";
  @override
  void initState() {
    userloggedin().whenComplete(() async {
      Timer(Duration(seconds: 5), () {
        finalemail == null
            ? Navigator.push(
                context, MaterialPageRoute(builder: (context) => loginscreen()))
            : Navigator.push(context,
                MaterialPageRoute(builder: (context) => afterloginclass()));
      });
    });
    super.initState();
  }

  Future userloggedin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var obtainedemail = prefs.getString('email');
    setState(() {
      finalemail = obtainedemail;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Splash Screen",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('assets/images/paw.png'),
            width: 100,
            height: 100,
          ),
          SizedBox(height: 10),
          Text(
            "Paw Finder",
            style: TextStyle(
                color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
          )
        ],
      )),
    );
  }
}
