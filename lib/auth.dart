import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Auth{
  static fetchAuth()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String auth = prefs.getString('auth');
    return jsonDecode(auth);
  }

  static Future setAuth(auth)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth',jsonEncode(auth));
  }
}