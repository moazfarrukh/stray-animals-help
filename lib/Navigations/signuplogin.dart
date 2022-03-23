import 'package:flutter/material.dart';
import 'package:helloworld/Navigations/login.dart';
import 'package:helloworld/constants.dart';

class signuploginscreen extends StatefulWidget {
  @override
  _signuploginscreenState createState() => _signuploginscreenState();
}

class _signuploginscreenState extends State<signuploginscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50,),
          Center(child:Image(image: AssetImage('assets/images/sshape.png'),width:100,height:100)),
          SizedBox(height: MediaQuery.of(context).size.height/1.5),
          Row(children: [
           RawMaterialButton(child:Container(
              alignment: Alignment.center,
              width: constantclass.buttonwidth,
              height: constantclass.buttonheight,
              margin: EdgeInsets.only(left: 15),
              decoration: BoxDecoration(color: constantclass.backgroundcolor,borderRadius: BorderRadius.circular(15)),
              child: Text("Log in",style: TextStyle(fontSize:22,fontWeight: FontWeight.w500,color: Colors.black)),
            ),onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>loginscreen()));
            },),
            SizedBox(width: 20,),
            Container(
              alignment: Alignment.center,
              width: constantclass.buttonwidth,
              height: constantclass.buttonheight,
              margin: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(color: constantclass.backgroundcolor,borderRadius: BorderRadius.circular(15)),
              child: Text("Sign up",style: TextStyle(fontSize:22,fontWeight: FontWeight.w500,color: Colors.black)),
            )
          ],)
        ],
      ),
    );
  }
}