import 'package:flutter/material.dart';
import 'package:helloworld/adoptions/adoptsearches.dart';

class adoptclass extends StatefulWidget {
  @override
  _adoptclassState createState() => _adoptclassState();
}

class _adoptclassState extends State<adoptclass> {
  String type = " ";
  String location = " ";
  var _formKey = GlobalKey<FormState>();
  TextEditingController typecont = TextEditingController();
  TextEditingController locationcont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: Text("Adopt",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold))),
      body: ListView(shrinkWrap: true, children: [
        SizedBox(height: 20),
        Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            width: 300,
            height: MediaQuery.of(context).size.height / 5,
            decoration: BoxDecoration(color: Colors.white),
            child: Form(
                key: _formKey,
                child: Column(children: [
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: typecont,
                    decoration: InputDecoration(
                        prefixIconConstraints: BoxConstraints(
                          minHeight: 32,
                          minWidth: 32,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        hintText: "Search by type,breed,etc",
                        hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.normal)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: locationcont,
                    decoration: InputDecoration(
                        prefixIconConstraints: BoxConstraints(
                          minHeight: 32,
                          minWidth: 32,
                        ),
                        prefixIcon: Icon(
                          Icons.place,
                          color: Colors.black,
                        ),
                        hintText: "City,State",
                        hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.normal)),
                  ),
                ]))),
        Container(
            margin: EdgeInsets.only(left: 30),
            color: Colors.white,
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 4.3,
            child: ListView(children: [
              Text(
                "Your previous searches",
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.history,
                    size: 30,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Dogs",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: SizedBox(
                      width: 10,
                      child: Text(
                        "Islamabad",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.normal),
                      ))),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.history,
                    size: 30,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Cats",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: SizedBox(
                      width: 10,
                      child: Text(
                        "Lahore",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.normal),
                      ))),
            ])),
        SizedBox(
          height: 10,
        ),
        Container(
            margin: EdgeInsets.only(left: 30),
            color: Colors.white,
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 2.5,
            child: ListView(children: [
              Text(
                "Try searching for",
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              RawMaterialButton(
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Cats,Persian,Islamabad",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.normal),
                      )
                    ],
                  ),
                  onPressed: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => resultsclass()));
                  }),
              SizedBox(
                height: 10,
              ),
              RawMaterialButton(
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Dog,Rottweiler,Lahore",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.normal),
                      )
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => resultsclass()));
                  }),
              SizedBox(
                height: 10,
              ),
              RawMaterialButton(
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Dog,BullDog,Lahore",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.normal),
                      )
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => resultsclass()));
                  })
            ]))
      ]),
    );
  }
}
