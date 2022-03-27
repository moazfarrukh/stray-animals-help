import 'package:flutter/material.dart';
import 'package:helloworld/constants.dart';

class tipsclass extends StatefulWidget {
  @override
  State<tipsclass> createState() => _tipsclassState();
}

class _tipsclassState extends State<tipsclass> {
  Container mycont(String txt) {
    return Container(
      width: 300,
      height: 250,
      decoration: BoxDecoration(
          color: constantclass.backgroundcolor,
          borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.only(left: 20),
      padding: EdgeInsets.all(20),
      child: Text(
        txt,
        style: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
          "Tips when facing strays",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400),
        )),
        body: SingleChildScrollView(
            child: Column(children: [
          SizedBox(
            height: 20,
          ),
          Text(
            "1) Stay calm and walk away",
            style: TextStyle(
                color: Colors.black, fontSize: 22, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10,
          ),
          mycont(
              "Do not run, as the dog will catch you and will be encouraged to bite. Don’t panic as it is not a pleasant situation to be in, agreed, but the calmer and more confident you are, the better. Many dogs naturally know how to take down a runner so search for something to climb onto and call for help."),
          SizedBox(height: 20),
          Text(
            "2) Freeze:  ",
            style: TextStyle(
                color: Colors.black, fontSize: 22, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10,
          ),
          mycont(
              "If a dog is growling or barking at you, just stop and stand still. Depending on the situation or how you feel, you could slowly sit or even lie down. But if you move they will further growl and bark, so do not do anything and wait"),
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(
                width: 5,
              ),
              Text(
                "3)",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                "Distract dog with another object:",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          mycont(
              "You should carry treats or toys when traveling in areas known to be home to dangerous dogs. If threatened by an angry dog, throw your treats away from you. The dog may go after these instead of you. Like this, you may distract him enough to give yourself time to escape."),
          SizedBox(
            height: 20,
          ),
          Text(
            "4) Send calming signals:",
            style: TextStyle(
                color: Colors.black, fontSize: 22, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10,
          ),
          mycont(
              "Remember that the majority of stray dogs are afraid of humans. There are easy ways you can signal to a dog that you have peaceful intent. Yawning, licking your lips, standing sideways to the dog, letting them approach and sniff you can help you in calming them."),
        ])));
  }
}
