import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class userprofile extends StatefulWidget {
  @override
  _userprofileState createState() => _userprofileState();
}

class _userprofileState extends State<userprofile> {
  String email = " ";
  bool isloading = true;
  var userindex = -1;
  int a = 0;
  int choiceforaccounts = 0;
  var list;
  var list1;
  loadData() async {
    //var doc1=await FirebaseFirestore.instance.collection("GoogleUsers").where('email',isEqualTo: FirebaseAuth.instance.currentUser.email).get();
    var doc = await FirebaseFirestore.instance
        .collection('Users')
        .where('email', isEqualTo: FirebaseAuth.instance.currentUser.email)
        .get();
    setState(() {
      list = doc.docs.first;
      a = 1;
      isloading = false;
      userindex = 1;
    });
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // ignore: missing_return
        body: (isloading)
            ? Center(child: CircularProgressIndicator())
            : StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('Users').snapshots(),
                builder: (BuildContext context, snapshots) {
                  if (!snapshots.hasData) {
                    return Center(
                        child: Text("No data",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.bold)));
                  } else if (snapshots.hasData) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          "My Information",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.person,
                              size: 30,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              list['name'],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.email,
                              size: 30,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              list['email'],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.phone,
                              size: 30,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              list['phone'],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.location_city,
                              size: 30,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              list['city'],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    );
                  }
                }));
  }
}
