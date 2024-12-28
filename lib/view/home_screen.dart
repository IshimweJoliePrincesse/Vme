import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:electa/models/announcements_model.dart';
import 'package:electa/utils/app_colors.dart';
import 'package:electa/utils/constants.dart';
import 'package:electa/view/complete_profile.dart';
import 'package:electa/view/dashboard.dart';
import 'package:electa/view/profile.dart';
import 'package:electa/view/setting_screen.dart';
import 'package:electa/view/upcoming_event_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  bool isLoading = false;
  int selectedIndex = 0;
  int statusIndex = 0;
  int selectedStatusIndex = 0;

  final tabs = [

    Dashboard(),
    UpcomingEventScreen(),
    Profile(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context){

    return Scaffold(
      body: tabs[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          _currentIndex = index;
          setState((){

          });
        },

        type: BottomNavigationBarType.shifting,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.black54,
        selectedFontSize: 16,
        showSelectedLabels: true,
        item: [BottomNavigationBarItem(icon: const Icon(Icons.home), label: "Home",),
        BottomNavigationBarItem(icon: const Icon(Icons.how_to_vote), label: "Election"),
        BottomNavigationBarItem(icon:  Icon(Icons.person), label: 'Profile'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings" )
        ],
      ),
    );
  }
}