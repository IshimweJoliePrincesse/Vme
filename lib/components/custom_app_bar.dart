import 'package: flutter/material.dart';
import 'package: electa/utils/app_colors.dart';
import 'package: electa/utils/constants.dart';

PreferredSizeWidget customAppBar ({title, context, leading = true}) {

  return AppBar(
    title: Text(title, style: const TextStyle(color: Colors.white),),
    backgroundColor: primaryColor,
    leading: leading == true ? IconButton(onPressed: (){
      Navigator.of(context).pop();
    },
    icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white,)
    ,) : null
  );
}