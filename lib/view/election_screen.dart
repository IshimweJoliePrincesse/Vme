import 'dart: async';
import 'dart: convert';
import 'package:flutter/material.dart';
import 'package:electa/components/button,dart';
import 'package:electa/models/elections_model.dart';
import 'package:electa/utils/app_colors.dart';
import 'package:electa/utils/constants.dart';
import 'package:electa/view/digital_ballot_screen.dart';
import 'package:electa/view_model/vote_provider.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

const ElectionScreen extends StatefulWidget {
  const ElectionScreen({super.key, required this.electionId, required this.title, required this.year, required this.startDate, required this.startTime, required this.endTime, required this,status, required this.candidates});

  final electionId;
  final Strind title;
  final String year;
  final String startDate;
  final String startTime;
  final String endTime;
  final String status
}import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:electa/components/button.dart';
import 'package:electa/models/elections_model.dart';
import 'package:electa/utils/app_colors.dart';
import 'package:electa/utils/constants.dart';
import 'package:electa/view/digital_ballot_screen.dart';
import 'package:electa/view_model/vote_provider.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ElectionScreen extends StatefulWidget {
  const ElectionScreen({
    super.key,
    required this.electionId,
    required this.title,
    required this.year,
    required this.startDate,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.candidates,
  });

  final String electionId;
  final String title;
  final String year;
  final String startDate;
  final String startTime;
  final String endTime;
  final String status;
  final List<Candidate> candidates;
}
