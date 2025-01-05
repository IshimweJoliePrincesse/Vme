import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:electa/components/custom_app_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:electa/utils/app_colors.dart';
import 'package:electa/view_model/announcement_provider.dart';
import 'package:electa/view_model/political_parties_provider.dart';
import 'package:provider/provider.dart';

class PoliticalPartiesScreen extends StatefulWidget {
  const PoliticalPartiesScreen({super.key});

  @override
  State<PoliticalPartiesScreen> createState()=> _PoliticalPartiesScreenState();
}

class _PoliticalPartiesScreenState extends State<PoliticalPartiesScreen> {

  List<Color> colorList = [
    Colors.teal,
    Colors.blueAccent,
    Colors.orange,
    Colors.blueAcccent,
    Colors.tealAccent,
    Colors.deepPurple,
    Colors.tealAccent,
    Colors.green,
    Colors.purple
  ];

  Color randomColors(List<Color> color){
    Random random = Random();
    return color[random.nextInt(colorList.length)];
  }

  @override

  Widget build(BuildContext context){
    final politicalPartiesProvider = Provider.of<PoliticalPartiesProvider>(context);

    return Scaffold(
      appBar: customAppBar(title: 'Official Parties', context: context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder(

                  future: politicalPartiesProvider.getParties(),
                  builder: (context, snapshot){

                    if(snapshot.connectionState == ConnectionState.waiting){
                      
                    }
                  }
                )
              )
            ]
          )
        )
      )
    )
  }
}