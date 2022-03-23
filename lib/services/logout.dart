import 'package:shared_preferences/shared_preferences.dart';

class logoutuser{
  Future getuserlogout()async{
   SharedPreferences prefs=await SharedPreferences.getInstance();
   prefs.clear();
  }
}