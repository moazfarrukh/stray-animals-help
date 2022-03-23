import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:helloworld/Navigations/home.dart';
import 'package:helloworld/Navigations/login.dart';
import 'package:helloworld/Navigations/signup.dart';
import 'package:helloworld/Navigations/signuplogin.dart';
import 'package:helloworld/services/databases.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
class firebaseservices{
   GoogleSignIn _googleSignIn = GoogleSignIn();
   int loading=0;
  GoogleSignInAccount _user;
  userdatabase object=userdatabase();
  Future registeruser(String name,String email,String phone,String city,String password)async{
    User user=(await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password)).user;
    object.saveuserdata(name, email, phone, city, user.uid);
    return user;
  }
  Future loginuser(String email,String password)async{
    User user=(await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)).user;
    return user;
  }
  Future googleauth()async{
        GoogleSignInAccount googleuser=await _googleSignIn.signIn();
        if(googleuser==null){
          return;
        }
        loading=1;
        _user=googleuser;
        GoogleSignInAuthentication auth=await googleuser.authentication;
        final AuthCredential credentials=GoogleAuthProvider.credential(idToken: auth.idToken,accessToken: auth.accessToken);
         return await FirebaseAuth.instance.signInWithCredential(credentials).then((value) => {
            // FirebaseFirestore.instance.collection("GoogleUsers").doc(_googleSignIn.currentUser.id).set({
            //   'name':googleuser.displayName,
            //   'email':googleuser.email,
            //   'image':googleuser.photoUrl,
            // })
            FirebaseFirestore.instance.collection('Users').add({
               'name':googleuser.displayName,
               'email':googleuser.email,
               'phone':'',
               'city':''
            })
         });
  }
  Future facebookauth()async{
              try{
              final LoginResult result=await FacebookAuth.instance.login(permissions: ['profile','email']);
              if(result.status==LoginStatus.success){
              final userdata=await FacebookAuth.instance.getUserData();
              FacebookAuthCredential facebookAuthCredential=FacebookAuthProvider.credential(result.accessToken.token);
              dynamic res=await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
              if(res!=null){
              await FirebaseFirestore.instance.collection("facebookusers").add({
                    'email':userdata['email'],
                    'name':userdata['name'],
                    'imageUrl':userdata['picture']['data']['url']
                });
              }
              }
              }catch(e){
                 print(e.toString());
              }
    }
    Future fblogin()async{
      FacebookAuth facebookAuth=FacebookAuth.instance;
      final LoginResult result=await facebookAuth.login();
      if(result.status==LoginStatus.success){
      Map mydata=await FacebookAuth.instance.getUserData(fields: 'email,name');
      final FacebookAuthCredential facebookAuthCredential=FacebookAuthProvider.credential(result.accessToken.token);
      FirebaseFirestore.instance.collection('facebookUsers').doc(FirebaseAuth.instance.currentUser.uid).set({'name':mydata['name'],'email':mydata['email'],'imageUrl':mydata['picture']['data']['url']});
      return await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential).then((value) {
        Get.to(loginscreen());
      });
      }
      else if(result.status==LoginStatus.cancelled){
        Get.to(signuploginscreen());
      }
    }

    Future userlogout()async{
      FirebaseAuth.instance.signOut();    
    }
    }