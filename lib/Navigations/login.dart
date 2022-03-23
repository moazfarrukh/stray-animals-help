import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:helloworld/Navigations/afterlogin.dart';
import 'package:helloworld/Navigations/signup.dart';
import 'package:helloworld/Navigations/signuplogin.dart';
import 'package:helloworld/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:helloworld/services/authservices.dart';
import 'package:shared_preferences/shared_preferences.dart';

class loginscreen extends StatefulWidget {
  @override
  _loginscreenState createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {
  firebaseservices object = firebaseservices();
  TextFormField textfeild(String hint, Icon feildicon, String error,
      TextEditingController txtedit, String feildname) {
    return TextFormField(
        controller: txtedit,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.text,
        onSaved: (String a) {
          feildname = a;
        },
        // ignore: missing_return
        validator: (String a) {
          if (feildname == "email") {
            if (!a.contains("@")) {
              return error;
            }
          } else if (feildname == "password") {
            if (a.length < 5) {
              return error;
            }
          }
        },
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(width: 5, color: Colors.white)),
            hintText: hint,
            hintStyle: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
            errorStyle: TextStyle(
                color: Colors.red, fontSize: 13, fontWeight: FontWeight.bold),
            fillColor: constantclass.backgroundcolor,
            filled: true,
            prefixIcon: Container(
                alignment: Alignment.center,
                width: 63,
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: feildicon)));
  }

  String email = " ";
  String password = " ";
  TextEditingController emailcont = TextEditingController();
  TextEditingController passcont = TextEditingController();
  var _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Image(
                image: AssetImage("assets/images/paw.png"),
                height: 100,
                width: 100),
            SizedBox(
              height: 5,
            ),
            Text("Log in",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w500)),
            SizedBox(height: 20),
            Container(
                width: 330,
                height: MediaQuery.of(context).size.height / 3.5,
                margin: EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      textfeild(
                          "abc@gmail.com",
                          Icon(
                            Icons.email,
                            color: Colors.black,
                            size: 30,
                          ),
                          "Please enter valid email",
                          emailcont,
                          "email"),
                      SizedBox(
                        height: 20,
                      ),
                      textfeild(
                          "password",
                          Icon(
                            Icons.lock,
                            color: Colors.black,
                            size: 30,
                          ),
                          "Please enter valid password",
                          passcont,
                          "password"),
                    ],
                  ),
                )),
            RawMaterialButton(
              child: Container(
                  padding: EdgeInsets.only(left: 130),
                  alignment: Alignment.center,
                  width: 330,
                  height: 62,
                  decoration: BoxDecoration(
                      color: constantclass.backgroundcolor,
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(children: [
                    Text("Log in",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.arrow_forward_sharp,
                      size: 25,
                      color: Colors.black,
                    )
                  ])),
              onPressed: () async {
                try {
                  if (_formkey.currentState.validate()) {
                    var result =
                        await object.loginuser(emailcont.text, passcont.text);
                    if (result != null) {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString('email', emailcont.text);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => afterloginclass())));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Error Signing in")));
                    }
                  }
                } catch (e) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: Text("Invalid email or password",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                )),
                            content: Text(
                              e.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                            actions: [
                              RawMaterialButton(
                                  child: Text("Ok",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400)),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  })
                            ]);
                      });
                }
              },
            ),
            SizedBox(
              height: 10,
            ),
            RawMaterialButton(
              child: Text("Forgot Password?",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              onPressed: () {},
            ),
            Row(children: <Widget>[
              Expanded(
                child: new Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 15.0),
                    child: Divider(
                      color: Colors.black,
                      thickness: 1.5,
                      height: 50,
                    )),
              ),
              Text("OR",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 23,
                      fontWeight: FontWeight.bold)),
              Expanded(
                child: new Container(
                    margin: const EdgeInsets.only(left: 15.0, right: 10.0),
                    child: Divider(
                      color: Colors.black,
                      thickness: 1.5,
                      height: 50,
                    )),
              ),
            ]),
            SizedBox(
              height: 15,
            ),
            RawMaterialButton(
              child: Container(
                  alignment: Alignment.center,
                  width: 330,
                  height: 62,
                  decoration: BoxDecoration(
                      color: constantclass.backgroundcolor,
                      borderRadius: BorderRadius.circular(15)),
                  child: Text("Sign up",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold))),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => singupscreen()));
              },
            ),
            SizedBox(
              height: 20,
            ),
            RawMaterialButton(
                child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    height: 70,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: constantclass.backgroundcolor,
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(children: [
                      Image(
                        image: AssetImage("assets/images/google.png"),
                        width: 50,
                        height: 32,
                      ),
                      SizedBox(width: 5),
                      Text("Sign in with google account",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold))
                    ])),
                onPressed: () async {
                  dynamic result1 = await object.googleauth();
                  if (result1 != null) {
                    SharedPreferences prefs1 =
                        await SharedPreferences.getInstance();
                    prefs1.setString('email', emailcont.text);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => afterloginclass()));
                  }
                }),
          ],
        )),
      ),
    );
  }
}
