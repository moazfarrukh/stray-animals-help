import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:path/path.dart';

class uploadPetClass extends StatefulWidget {
  uploadPetClass({Key key}) : super(key: key);

  @override
  _uploadPetClassState createState() => _uploadPetClassState();
}

class _uploadPetClassState extends State<uploadPetClass> {
  final db = FirebaseFirestore.instance;
  bool ischecked = false;
  bool visible = false;
  TextEditingController textcont = TextEditingController();
  TextEditingController typecont = TextEditingController();

  TextEditingController contactcont = TextEditingController();
  TextEditingController locationcont = TextEditingController();
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  File _photo;
  final ImagePicker _picker = ImagePicker();
  Future<void> getDownloadURL(String id, BuildContext context) async {
    String imageUrl = await storage.ref('adopt/$id.jpg').getDownloadURL();

    await db.collection("adopt").doc(id).update({'url': imageUrl});
    loadProgress();
    alertDialog(context, "Success",
        "The animal has been Successfully added to the adoption list");
  }

  Future imgFromGallery(BuildContext context) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        this._photo = File(pickedFile.path);
        alertDialog(context, "Success", "image added");
      }
      if (this._photo != null) {
      } else {
        alertDialog(context, "Error", "No image selected");
      }
    });
  }

  Future<bool> alertDialog(BuildContext context, String title, String text) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(text),
            actions: <Widget>[
              TextButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  Future uploadFile(String fileName, BuildContext context) async {
    if (this._photo == null) return;
    final destination = 'adopt/$fileName.jpg';
    try {
      final ref = firebase_storage.FirebaseStorage.instance.ref(destination);
      await ref.putFile(this._photo);
      await getDownloadURL(fileName, context);
    } catch (e) {
      print('error occured');
    }
  }

  loadProgress() {
    setState(() {
      visible = !visible;
    });
  }

  Future uploadData(BuildContext context) async {
    if (typecont.text != "" &&
        locationcont.text != "" &&
        contactcont.text != "" &&
        this._photo != null) {
      loadProgress();
      await db
          .collection("adopt")
          .add({
            "type": typecont.text,
            "description": textcont.text,
            "contact": contactcont.text,
            "location": locationcont.text,
            "shelter-attention": this.ischecked
          })
          .then((value) => {uploadFile(value.id, context)})
          .catchError((error) =>
              (alertDialog(context, "Error", "Failed to add animal: $error")));
      textcont.clear();
      typecont.clear();
      locationcont.clear();
      contactcont.clear();
      this.ischecked = false;
      this._photo = null;
    } else {
      if (contactcont.text == "") {
        alertDialog(
            context, "Contact info not found", "Enter your phone number");
      } else if (typecont.text == "") {
        alertDialog(context, "Type not found", "Enter the type of the animal");
      } else if (locationcont.text == "") {
        alertDialog(context, "Location not found",
            "Please enter location the of the animal");
      } else if (this._photo == null) {
        alertDialog(
            context, "image not found", "Upload the image of the animal");
      }
    }

    try {} catch (e) {
      print('error occured');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Animal'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  child: const Tab(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1507146426996-ef05306b995a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cHVwcHklMjBkb2d8ZW58MHx8MHx8&w=1000&q=80'),
                    ),
                  ),
                ),
                Text(FirebaseAuth.instance.currentUser.displayName),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  height: 100,
                  width: 350,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
                  child: TextField(
                    controller: typecont,
                    maxLines: null,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Type of animal e.g dog,cat etc.',
                      fillColor: Color.fromARGB(255, 219, 219, 219),
                      filled: true,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  height: 100,
                  width: 350,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
                  child: TextField(
                    controller: textcont,
                    maxLines: null,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'description of animal',
                      fillColor: Color.fromARGB(255, 219, 219, 219),
                      filled: true,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  height: 100,
                  width: 350,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
                  child: TextField(
                    controller: locationcont,
                    maxLines: null,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'location of animal',
                      fillColor: Color.fromARGB(255, 219, 219, 219),
                      filled: true,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  height: 90,
                  width: 350,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
                  child: TextField(
                    controller: contactcont,
                    maxLines: null,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(13),
                    ],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Your contact information',
                      fillColor: Color.fromARGB(255, 219, 219, 219),
                      filled: true,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  height: 70,
                  width: 350,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Shelter attention required',
                        style: TextStyle(fontSize: 17),
                      ),
                      Checkbox(
                        value: this.ischecked,
                        onChanged: (bool value) {
                          setState(() {
                            this.ischecked = value;
                          });
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 105, vertical: 5),
                  child: ElevatedButton(
                      style: OutlinedButton.styleFrom(
                        shape: const StadiumBorder(),
                        side: const BorderSide(width: 4, color: Colors.blue),
                      ),
                      onPressed: () {
                        imgFromGallery(context);
                      },
                      child: const Text("Attach Image")),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 125, vertical: 5),
                  child: ElevatedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(width: 2, color: Colors.blue),
                      ),
                      onPressed: () {
                        uploadData(context);
                      },
                      child: const Text("Upload")),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Visibility(
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: visible,
                    child: Container(
                        margin: EdgeInsets.only(top: 50, bottom: 30),
                        child: CircularProgressIndicator(
                          color: Colors.blue,
                          strokeWidth: 5,
                        ))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
