import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class userdatabase{
  CollectionReference userdata=FirebaseFirestore.instance.collection("Users");
  Future saveuserdata(String name,String email,String phone,String city,String uid)async{
    await userdata.doc(uid).set({'name':name,'email':email,'phone':phone,'city':city});
  }
}