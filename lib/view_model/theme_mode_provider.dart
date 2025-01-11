import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  int selected = 1;

  ThemeMode get themeMode => _themeMode;
  changeThemeMode(themeMode, selectedValue) async {
    
  }
}
