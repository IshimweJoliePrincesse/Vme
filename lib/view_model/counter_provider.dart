import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CounterProvider with ChangeNotifier {
  int _counter = 0;
  int get counter => _counter;

  incrementCounter(){
    
  }
}
