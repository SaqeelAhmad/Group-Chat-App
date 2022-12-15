import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class Utility {

  static String getHumanReadableDate( String dts) {
    var dt = int.parse(dts);
    DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(dt);
    return DateFormat('dd MMM yyyy hh:mm a').format(dateTime);
  }

  void toastMessege(String messege) {
    Fluttertoast.showToast(msg: messege,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.blueGrey,
      textColor: Colors.white,
      fontSize: 18,);
  }


}