import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:helloworld/constants.dart';
import 'package:helloworld/vets/nearbyvets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class vetprofileclass extends StatefulWidget {
  final QueryDocumentSnapshot doc;
  Map userloc;
  vetprofileclass({Key key, @required this.doc, this.userloc})
      : super(key: key);
  @override
  _vetprofileclassState createState() => _vetprofileclassState();
}

class _vetprofileclassState extends State<vetprofileclass> {
  String _url = "https://www.google.com/maps/dir//";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
          "Vet Profile",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        )),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
                height: MediaQuery.of(context).size.height / 1.5,
                decoration: BoxDecoration(
                    color: constantclass.backgroundcolor,
                    borderRadius: BorderRadius.circular(15)),
                width: double.infinity,
                margin: EdgeInsets.only(left: 20, right: 20),
                padding: EdgeInsets.only(top: 10, left: 15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                              'https://thumbs.dreamstime.com/b/homeless-shelter-real-estate-concept-close-up-child-hands-holding-white-paper-house-heart-green-background-flat-lay-copy-164579567.jpg'),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    ListView(
                      shrinkWrap: true,
                      children: [
                        Text(
                          widget.doc.get('name') ?? '',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Location",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.doc.get('location').trim() ?? '',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.normal),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Contact",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.doc.get('contact') ?? '',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.normal),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  ],
                )),
            SizedBox(
              height: 25,
            ),
            Row(
              children: [
                RawMaterialButton(
                  child: Container(
                    width: 150,
                    height: 70,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                        color: constantclass.backgroundcolor,
                        borderRadius: BorderRadius.circular(15)),
                    child: Text("Back",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        )),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                RawMaterialButton(
                  child: Container(
                    width: 150,
                    height: 70,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 50),
                    decoration: BoxDecoration(
                        color: constantclass.backgroundcolor,
                        borderRadius: BorderRadius.circular(15)),
                    child: Text("Get direction",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        )),
                  ),
                  onPressed: () {
                    launch(
                      Uri.encodeFull(_url +
                          widget.doc.get('location').replaceAll(' ', '+')),
                    );
                  },
                )
              ],
            )
          ],
        ));
  }
}
