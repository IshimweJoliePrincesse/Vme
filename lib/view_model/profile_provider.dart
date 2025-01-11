import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:electa/components/snack.dart';
import 'package:electa/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider with ChangeNotifier {
  dynamic user;
  List<String>? splitImage;
  Future<void> updateProfile(BuildContext context, String phone, String email) async {
    
  }
}
