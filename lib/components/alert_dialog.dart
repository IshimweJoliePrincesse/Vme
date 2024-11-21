import 'package:flutter/material.dart';
import 'package:electa/utils/app_colors.dart';

Future alertDialog({required context, dismissable = true, required title, required content, required actions}){
  return showDialog(barrierDismissable: dismissable, context: context, builder: (context){
    return AlertDialog(title: Text(title), content: Text(content), actions: actiond);
  });
}