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
                      return const Center(child: CircularProgressIndicator());
                    } else if(snapshot.hasError){
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    else{
                      return GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), scrollDirection: Axis.vertical, itemCount: politicalPartiesProvider.partiesList.length, itemBuilder: (context, index){

                        String image = politicalPartiesProvider.partiesList[index].identification.toString();
                        List<String> splitImage = image.split(',');

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                          child: InkWell(
                            onTap: (){
                              showBottomSheet(context, context,
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30)
                                )
                              ),
                              constraints: BoxConstraints(
                                maxHeight: MediaQuery.of(context).size.height * 1.5
                              ),
                              builder: (context){
                                return Container(
                                  decoration: BoxDecoration(

                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30)
                                    )
                                  ),
                                  child: SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.all(30.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Center(child: Icon(Icons.arrow_drop_down_circle_outlined)),
                                          Text(politicalPartiesProvider.partiesList[index].name.toString() ?? '',
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          )),
                                          const SizedBox(height: 5,),
                                          Text(politicalPartiesProvider.partiesList[insex].description.toString() ?? '',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400
                                          )),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                              );
                            },
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 150,
                              margin: const EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                color: randomColors(colorList),
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Center(child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:[
                                  SizedBox(height: 50, child: Image.memory(base64Decode(splitImage[splitImage.length-1]))),

                                  Text(politicalPartiesProvider.partiesList[index].name.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0, color: Colors.white),),
                                ],
                              ))
                            ),
                          ),
                        );
                      })
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