import 'package:flutter/material.dart';
import 'package:helloworld/constants.dart';
import 'package:helloworld/shelters/shelterprofile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/foundation.dart';

class shelterclass extends StatefulWidget {
  @override
  _shelterclassState createState() => _shelterclassState();
}

class _shelterclassState extends State<shelterclass> {
  final db = FirebaseFirestore.instance;
  String search = " ";
  TextEditingController searchcont = TextEditingController();
  BitmapDescriptor mapmarker;
  Set<Marker> _markers = {};
  void _onMapCreated(GoogleMapController cont) {
    setState(() {
      _markers.add(Marker(
          icon: mapmarker,
          markerId: MarkerId('id-1'),
          position: LatLng(22.5448131, 88.3403691),
          infoWindow: InfoWindow(title: "Some shelter")));
    });
  }

  void markericon() async {
    mapmarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/paw.png');
  }

  @override
  void initState() {
    markericon();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shelters",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
          stream: db.collection('shelters').snapshots(),
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
                Container(
                  width: double.infinity,
                  height: 400,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                      color: constantclass.backgroundcolor,
                      borderRadius: BorderRadius.circular(15)),
                  child: GoogleMap(
                    gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                      new Factory<OneSequenceGestureRecognizer>(
                        () => new EagerGestureRecognizer(),
                      ),
                    ].toSet(),
                    onMapCreated: _onMapCreated,
                    markers: _markers,
                    initialCameraPosition: CameraPosition(
                        target: LatLng(22.5448131, 88.3403691), zoom: 15),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Nearby shelters",
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
                    "Nearby shelters",
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
                                  fontSize: 20,
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
                                      shelterprofileclass(doc: doc)));
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
