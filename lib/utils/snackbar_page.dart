import 'package:flutter/material.dart';

class SnackbarPage {
  static void showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    if(!context.mounted)return;
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
