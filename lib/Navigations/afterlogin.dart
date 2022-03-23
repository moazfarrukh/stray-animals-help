import 'package:flutter/material.dart';
import 'package:helloworld/Navigations/home.dart';
import 'package:helloworld/constants.dart';
import 'package:helloworld/Navigations/getuserdata.dart';
import 'package:helloworld/adoptions/uploadpet.dart';

class afterloginclass extends StatefulWidget {
  @override
  _afterloginclassState createState() => _afterloginclassState();
}

class _afterloginclassState extends State<afterloginclass> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    homeclass(),
    uploadPetClass(),
    Text('Profile Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    userprofile()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30,
                color: Colors.black,
              ),
              label: 'Home',
              backgroundColor: constantclass.backgroundcolor),
          BottomNavigationBarItem(
              icon:
                  Icon(Icons.add_circle_rounded, size: 30, color: Colors.black),
              label: 'Add',
              backgroundColor: constantclass.backgroundcolor),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite, size: 30, color: Colors.black),
              label: 'Favourites',
              backgroundColor: constantclass.backgroundcolor),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 30, color: Colors.black),
              label: 'Profile',
              backgroundColor: constantclass.backgroundcolor),
        ],
        type: BottomNavigationBarType.shifting,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        iconSize: 40,
        onTap: _onItemTapped,
        elevation: 10,
        backgroundColor: constantclass.backgroundcolor,
      ),
    );
  }
}
