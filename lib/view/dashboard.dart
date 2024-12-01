import 'dart:convert';
import 'package:carousel_slider/carousel_sliider.dart';
import 'package:flutter/material.dart';
import 'package:electa/models/elections_model.dart';
import 'package:electa/utils/app_colors.dart';
import 'package:electa/utils/constants.dart';
import 'package:electa/view/current_events_screen.dart';
import 'package:electa/view/view/election_screen.dart';
import 'package:electa/view/official_view/news_announcements_screen.dart';
import 'package:electa/view/political_parties_screen.dart';
import 'package:electa/view/profile.dart';
import 'package:electa/view/results_screen.dart';
import 'package:electa/view/setting_screen.dart';
import 'package:electa/view/upcoming_event_screen.dart';
import 'package:electa/view_model/announcement_provider.dart';
import 'package:electa/view_model/election_provider';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Dashboard extends StatefulWidget {
    const Dashboard({super.key});

    @override
    State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

    int _currentIndex = 0;
    bool emptyEvent = false;

    bool isLoading = false;
    int selectedIndex =0;
    bool isPressed = false;
    dynamic user;
    String status = 'all';
    int statusIndex = 0;
    int selectedStatusIndex = 0;
}