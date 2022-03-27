import 'package:flutter/material.dart';
import 'package:helloworld/adoptions/adoptsearches.dart';
import 'package:helloworld/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class petItclass extends StatefulWidget {
  final QueryDocumentSnapshot doc;
  petItclass({Key key, @required this.doc}) : super(key: key);

  @override
  _petItclassState createState() => _petItclassState(doc: doc);
}

class _petItclassState extends State<petItclass> {
  final QueryDocumentSnapshot doc;
  _petItclassState({Key key, this.doc});
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Adopt the Animal',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
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
                        backgroundImage: NetworkImage(doc
                                .data()
                                .toString()
                                .contains('url')
                            ? doc.get('url')
                            : 'https://dm6g3jbka53hp.cloudfront.net/static-images/adopt-me-pet-02032021.jpg'),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ListView(
                    shrinkWrap: true,
                    children: [
                      //will be using per database
                      Text(
                        doc.get('type'),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        doc.get('shelter-attention')
                            ? "Shelter attention  is required for this ${doc.get('type')}"
                            : "",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Location",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        doc.get('location'),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Description",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        doc.get('description'),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
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
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        doc.get('contact'),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => resultsclass()));
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
                  child: Text("Pet it",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      )),
                ),
                onPressed: () {
                  _makePhoneCall(doc.get('contact'));
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
