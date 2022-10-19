import 'package:flutter/material.dart';

class SnackUtils {
  static void show(BuildContext context, String str) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(str)));
  }
}
