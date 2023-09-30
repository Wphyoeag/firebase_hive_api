import 'package:firebase_auth_log_in/main.dart';
import 'package:flutter/material.dart';

class Utils{
  static showSnackBar(String text){
    final snackBar=SnackBar(content: Text(text),backgroundColor: Colors.red,);
    messengerKey.currentState!..removeCurrentSnackBar()..showSnackBar(snackBar);
  }
}