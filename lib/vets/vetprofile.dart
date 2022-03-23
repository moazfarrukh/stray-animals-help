import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:helloworld/constants.dart';
import 'package:helloworld/vets/nearbyvets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class vetprofileclass extends StatefulWidget {
  final QueryDocumentSnapshot doc;
  vetprofileclass({Key key, @required this.doc}) : super(key: key);
  @override
  _vetprofileclassState createState() => _vetprofileclassState(doc: doc);
}

class _vetprofileclassState extends State<vetprofileclass> {
  final QueryDocumentSnapshot doc;
  _vetprofileclassState({Key key, this.doc});
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
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                              'https://thumbs.dreamstime.com/b/homeless-shelter-real-estate-concept-close-up-child-hands-holding-white-paper-house-heart-green-background-flat-lay-copy-164579567.jpg'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //name of vet as per database
                            //location of vet as per database
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    ListView(
                      shrinkWrap: true,
                      children: [
                        Text(
                          doc.get('name'),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          doc.get('location'),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          doc.get('contact') ?? '',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.normal),
                          textAlign: TextAlign.left,
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => vetsclass()));
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
                      Uri.encodeFull(
                          _url + doc.get('location').replaceAll(' ', '+')),
                    );
                  },
                )
              ],
            )
          ],
        ));
  }
}
