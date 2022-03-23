import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:helloworld/adoptions/adopt.dart';
import 'package:helloworld/adoptions/adoptsearches.dart';
import 'package:helloworld/Navigations/login.dart';
import 'package:helloworld/Navigations/splash.dart';
import 'package:helloworld/constants.dart';
import 'package:helloworld/services/logout.dart';
import 'package:helloworld/shelters/shelter.dart';
import 'package:helloworld/vets/nearbyvets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class homeclass extends StatefulWidget {
  @override
  _homeclassState createState() => _homeclassState();
}

class _homeclassState extends State<homeclass> {
  Position _currentPosition;
  String _currentAddress;
  String currlatitude = " ";
  String currlongitude = " ";
  // Geolocator geolocator = Geolocator();
  splashscreen splashobj = splashscreen();
  logoutuser object = logoutuser();
  _getCurrentLocation() async {
    final geoposition = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    setState(() {
      currlatitude = '${geoposition.latitude}';
      currlongitude = '${geoposition.longitude}';
    });
  }

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: RawMaterialButton(
              onPressed: () async {
                FirebaseAuth.instance.signOut();
                object.getuserlogout();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => loginscreen()),
                    (route) => false);
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                width: 100,
                height: 35,
                child: Text(
                  "Log Out",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ))),
      endDrawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Image(
                  image: AssetImage('assets/images/paw.png'),
                  width: 56,
                  height: 69,
                ),
                SizedBox(
                  width: 7,
                ),
                Text(
                  "Pawfinder",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.normal),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                RawMaterialButton(
                    child: Container(
                      width: 170,
                      height: 122,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 17),
                      decoration: BoxDecoration(
                          color: constantclass.backgroundcolor,
                          borderRadius: BorderRadius.circular(30)),
                      child: Column(
                        children: [
                          Image(
                            image: AssetImage('assets/images/shelters.png'),
                            width: 46,
                            height: 83,
                          ),
                          Text(
                            "Nearest Shelters",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => shelterclass()));
                    }),
                SizedBox(
                  width: 5,
                ),
                RawMaterialButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => vetsclass()));
                    },
                    child: Container(
                      width: 170,
                      height: 122,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 15),
                      decoration: BoxDecoration(
                          color: constantclass.backgroundcolor,
                          borderRadius: BorderRadius.circular(30)),
                      child: Column(
                        children: [
                          Image(
                            image: AssetImage('assets/images/vet.png'),
                            width: 46,
                            height: 83,
                          ),
                          Text(
                            "Nearest Veterinarian",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 17),
                          )
                        ],
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                RawMaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => resultsclass()));
                    },
                    child: Container(
                      width: 170,
                      height: 122,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 17),
                      decoration: BoxDecoration(
                          color: constantclass.backgroundcolor,
                          borderRadius: BorderRadius.circular(30)),
                      child: Column(
                        children: [
                          Image(
                            image: AssetImage('assets/images/adopt.png'),
                            width: 46,
                            height: 83,
                          ),
                          Text(
                            "Adopt",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 18),
                          )
                        ],
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
