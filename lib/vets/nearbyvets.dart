import 'package:flutter/material.dart';
import 'package:helloworld/constants.dart';
import 'package:helloworld/vets/vetprofile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class vetsclass extends StatefulWidget {
  @override
  _vetsclassState createState() => _vetsclassState();
}

class _vetsclassState extends State<vetsclass> {
  final db = FirebaseFirestore.instance;
  String search = " ";
  TextEditingController searchcont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Veterinarians",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
          stream: db.collection('vets').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return ListView(children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 352,
                  height: 50,
                  margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    onSubmitted: (String a) {
                      search = a;
                    },
                    controller: searchcont,
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: EdgeInsetsDirectional.only(end: 12),
                        child:
                            Icon(Icons.search, color: Colors.black, size: 25),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              BorderSide(color: Colors.black, width: 5)),
                      hintText: "Search",
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Nearby vets",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                )
              ]);
            } else {
              return ListView(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 352,
                    height: 50,
                    margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      onSubmitted: (String a) {
                        search = a;
                      },
                      controller: searchcont,
                      decoration: InputDecoration(
                        suffixIcon: Padding(
                          padding: EdgeInsetsDirectional.only(end: 12),
                          child:
                              Icon(Icons.search, color: Colors.black, size: 25),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.black, width: 5)),
                        hintText: "Search",
                        hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Nearby vets",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ].toList()
                  ..addAll(snapshot.data.docs.map((doc) {
                    return Column(children: [
                      RawMaterialButton(
                        child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: constantclass.backgroundcolor,
                                borderRadius: BorderRadius.circular(20)),
                            height: 92,
                            width: double.infinity,
                            margin: EdgeInsets.only(left: 30, right: 30),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage(
                                    'https://thumbs.dreamstime.com/b/homeless-shelter-real-estate-concept-close-up-child-hands-holding-white-paper-house-heart-green-background-flat-lay-copy-164579567.jpg'),
                              ),
                              title: Text(
                                doc.get('name') ?? '',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18,
                                ),
                              ),
                              subtitle: Text(
                                doc.get('location') ?? '',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            )),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      vetprofileclass(doc: doc)));
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ]);
                  })),
              );
            }
          }),
    );
  }
}
