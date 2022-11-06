import 'package:flutter/material.dart';
import '../constants/constants.dart';

class Utils {
  static void showSnackBar(BuildContext context, String message, int duration) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: duration),
      backgroundColor: kPrimaryColor.withOpacity(0.5),
    ));
  }
}
