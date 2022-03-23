// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/Navigations/afterlogin.dart';
import 'package:helloworld/Navigations/home.dart';
import 'package:helloworld/Navigations/login.dart';
import 'package:helloworld/Navigations/signuplogin.dart';
import 'package:helloworld/constants.dart';
import 'package:helloworld/services/authservices.dart';

class singupscreen extends StatefulWidget {
  @override
  _singupscreenState createState() => _singupscreenState();
}

class _singupscreenState extends State<singupscreen> {
  Map userdatamap;
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
          } else if (feildname == "phone") {
            if (a.length < 11) {
              return error;
            }
          } else if (feildname == "name") {
            if (a.length == 0) {
              return error;
            }
          } else if (feildname == "city") {
            if (a.length == 0) {
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

  String name = " ";
  String email = " ";
  String phone = " ";
  String city = " ";
  String password = " ";
  TextEditingController namecont = TextEditingController();
  TextEditingController emailcont = TextEditingController();
  TextEditingController phonecont = TextEditingController();
  TextEditingController citycont = TextEditingController();
  TextEditingController passwordcont = TextEditingController();
  var _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Center(
            child: SafeArea(
                bottom: true,
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Image(
                        image: AssetImage("assets/images/paw.png"),
                        height: 50,
                        width: 700),
                    SizedBox(
                      height: 5,
                    ),
                    Text("Sign up",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.w500)),
                    SizedBox(height: 10),
                    Container(
                        width: 330,
                        height: 480,
                        margin: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Form(
                          key: _formkey,
                          child: Column(
                            children: [
                              textfeild(
                                  "name",
                                  Icon(
                                    Icons.person,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                  "Please enter valid name",
                                  namecont,
                                  "name"),
                              SizedBox(height: 10),
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
                                height: 10,
                              ),
                              textfeild(
                                  "contact number",
                                  Icon(
                                    Icons.account_box_rounded,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                  "Please enter valid contact number must be 11 digits",
                                  phonecont,
                                  "phone"),
                              SizedBox(
                                height: 10,
                              ),
                              textfeild(
                                  "city",
                                  Icon(
                                    Icons.location_city,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                  "Please enter valid city",
                                  citycont,
                                  "city"),
                              SizedBox(
                                height: 10,
                              ),
                              textfeild(
                                  "password",
                                  Icon(
                                    Icons.lock,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                  "Please enter valid password",
                                  passwordcont,
                                  "password"),
                            ],
                          ),
                        )),
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
                                  fontWeight: FontWeight.bold)),
                        ),
                        onPressed: () async {
                          try {
                            if (_formkey.currentState.validate()) {
                              var res = await object.registeruser(
                                  namecont.text,
                                  emailcont.text,
                                  phonecont.text,
                                  citycont.text,
                                  passwordcont.text);
                              if (res != null) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => loginscreen()));
                              }
                            }
                          } catch (e) {
                            // ignore: missing_return
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      title: Text(
                                        "Registration failed!",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      content: Text(
                                        e.toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      actions: [
                                        RawMaterialButton(
                                            child: Text(
                                              "OK",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            })
                                      ]);
                                });
                          }
                        }),
                    Row(children: <Widget>[
                      Expanded(
                        child: new Container(
                            margin:
                                const EdgeInsets.only(left: 10.0, right: 15.0),
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
                            margin:
                                const EdgeInsets.only(left: 15.0, right: 10.0),
                            child: Divider(
                              color: Colors.black,
                              thickness: 1.5,
                              height: 50,
                            )),
                      ),
                    ]),
                    RawMaterialButton(
                      child: Container(
                          alignment: Alignment.center,
                          width: 330,
                          height: 62,
                          decoration: BoxDecoration(
                              color: constantclass.backgroundcolor,
                              borderRadius: BorderRadius.circular(15)),
                          child: Text("Log in",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold))),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => loginscreen()));
                      },
                    ),
                    //  SizedBox(height: 10,),
                    //    RawMaterialButton(child:Container(decoration: BoxDecoration(color: constantclass.backgroundcolor,borderRadius: BorderRadius.circular(15)),height: 70,width: double.infinity,margin: EdgeInsets.only(left:20,right:20),child:Row(children:[
                    //       Image(image: AssetImage("assets/images/google.png"),width: 60,height: 52,),
                    //       SizedBox(width: 10,),
                    //       Text("Sign in with google account",style:TextStyle(color: Colors.black,fontSize:20,fontWeight:FontWeight.bold))
                    //       ]))
                    //       ,onPressed: ()async{
                    //      try{
                    //      dynamic result=await object.googleauth();
                    //      if(result!=null){
                    //         Navigator.push(context, MaterialPageRoute(builder: (context)=>afterloginclass()));
                    //      }
                    //      }catch(e){
                    //        print(e.toString());
                    //      }
                    //    }),
                  ],
                )))));
  }
}
