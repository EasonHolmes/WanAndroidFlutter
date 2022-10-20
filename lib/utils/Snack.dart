import 'package:flutter/material.dart';

class SnackUtils {
  static void show(BuildContext context, String? str) {
    if(str!=null && str.isNotEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(str)));
    }
  }
}
