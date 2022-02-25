import 'package:flutter/material.dart';

class AlertHelper {
  static void showSnackbar(String title, GlobalKey<ScaffoldState> scaffoldKey) {
    final snackBar = SnackBar(
      content: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
    );
    scaffoldKey.currentState!.showSnackBar(snackBar);
  }
}
