import 'package:flutter/material.dart';

abstract class ErrorSnackBar {
  static void showScaffoldSnackBarPostFrame(
      BuildContext context, String title) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(title),
        backgroundColor: Theme.of(context).errorColor,
      ));
    });
  }
}
