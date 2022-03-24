import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:helloworld/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';

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
            SizedBox(height: 40),
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
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(width: 5, color: Colors.white)),
                          hintText: "Enter Pet type",
                          hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                          errorStyle: TextStyle(
                              color: Colors.red,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                          fillColor: constantclass.backgroundcolor,
                          filled: true,
                          suffixIcon: Container(
                              alignment: Alignment.center,
                              width: 63,
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Icon(
                                Icons.pets,
                                color: Colors.black,
                              )))),
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
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(width: 5, color: Colors.white)),
                          hintText: "Description of animal",
                          hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                          errorStyle: TextStyle(
                              color: Colors.red,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                          fillColor: constantclass.backgroundcolor,
                          filled: true,
                          suffixIcon: Container(
                              alignment: Alignment.center,
                              width: 63,
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Icon(
                                Icons.message,
                                color: Colors.black,
                              )))),
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
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(width: 5, color: Colors.white)),
                          hintText: "Location of animal",
                          hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                          errorStyle: TextStyle(
                              color: Colors.red,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                          fillColor: constantclass.backgroundcolor,
                          filled: true,
                          suffixIcon: Container(
                              alignment: Alignment.center,
                              width: 63,
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Icon(
                                Icons.place,
                                color: Colors.black,
                              )))),
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
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(width: 5, color: Colors.white)),
                          hintText: "Your contact information",
                          hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                          errorStyle: TextStyle(
                              color: Colors.red,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                          fillColor: constantclass.backgroundcolor,
                          filled: true,
                          suffixIcon: Container(
                              alignment: Alignment.center,
                              width: 63,
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Icon(
                                Icons.contact_phone,
                                color: Colors.black,
                              )))),
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
                RawMaterialButton(
                  child: Container(
                    alignment: Alignment.center,
                    width: 300,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(15)),
                    margin: EdgeInsets.only(left: 30, right: 30),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 105, vertical: 5),
                    child: const Text("Attach Image"),
                  ),
                  onPressed: () {
                    imgFromGallery(context);
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RawMaterialButton(
                  child: Container(
                    alignment: Alignment.center,
                    width: 300,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(15)),
                    margin: EdgeInsets.only(left: 30, right: 30),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 105, vertical: 5),
                    child: const Text("Upload Image"),
                  ),
                  onPressed: () {
                    imgFromGallery(context);
                  },
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
