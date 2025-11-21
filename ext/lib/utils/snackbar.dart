import 'package:flutter/material.dart';

class Snackbar {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static void show(String message) {
    final snackBar = SnackBar(content: Text(message));

    messengerKey.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}