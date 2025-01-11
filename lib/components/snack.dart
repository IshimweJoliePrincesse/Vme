import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showSnackBar(
    {required BuildContext context,
    required String title,
    Color color = Colors.black54,
    int seconds = 2}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(title),
    backgroundColor: color,
    showCloseIcon: true,
    dismissDirection: DismissDirection.horizontal,
    duration: Duration(seconds: seconds),
  ));
}
