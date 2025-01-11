import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:electa/components/button.dart';
import 'package:electa/models/elections_model.dart';
import 'package:electa/utils/app_colors.dart';
import 'package:electa/utils/app_styles.dart';
import 'package:electa/view/home_screen.dart';
import 'package:electa/view/official_view/official_home_screen.dart';
import 'package:electa/view_model/vote_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DigitalBallotScreen extends StatefulWidget {
  const DigitalBallotScreen({super.key, required this.electionId, required this.candidates});

  final List<Candidates> candidates;
  final electionId;

  @override
  State<DigitalBallotScreen> createState() =>_DigitalBallotScreenState();
}

class _DigitalBallotScreenState extends State<DigitalBallotScreen>{

  bool isSelected = false;
  int? _index;
  Color isSelectedColor = Colors.green;
  double maxTime = 60;
  int timeLeft = 60;
  double second = 1.0;
  bool voted = false;

  List<Image> candidateImages = [];

  Timer? _timer;

  startTimer(){
    _timer = Timer.periodic(const Duration(seconds: 1), (timer){

      if(timeLeft>0){
        setState((){
          timeLeft--;
          second = second-0.5;
        });
      } else {
        timer.cancel();

        if(voted == true){
          return;
        }

        showDialog(barrierColor: Colors.grey.withOpacity(0.6), barrierDismissible: false, context: context, builder:(context){
          return PopScope(
            canPop: false,
            child: AlertDialog(title: const Column(children: [Icon(Icons.timer, size: 25), SizedBox(height: 5), Text('Time finished')],),
            content: const Text("Your voting time just finished"),
            actions: [
              Center(
                child: SizedBox(
                  width: 150,
                  child: Button(tap: (){
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const HomeScreen()), (route)=>route is OfficialHomeScreen);
                  }, text: 'GO BACK', color: Colors.red, fontSize: 18, borderRadius: 10,),
                ),
              ),
            ],),
          );
        });
      }
    });
  }
  @override
  void initState(){
    debugPrint(widget.candidates[0].party);

    for(var candidate in widget.candidates){
      candidateImages.add(Image.memory(
        base64Decode(candidate.photo.toString()),
        width: 40,
        height: 40,
        fit: BoxFit.fitHeight,
      ));
    }

    startTimer();

    super.initState();
  }

  @override

  void dispose(){

    _timer?.cancel();
    super.dispose();
  }

  @override

  Widget build(BuildContext context){
    final voteProvider = Provider.of<VoteProvider>(context);
    return Scaffold(

      body: SafeArea(child:
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
          child: Column(
            children:[
              Text(AppLocalizations.of(context)!.digital_ballot, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
              const SizedBox(height: 5),
              Text(AppLocalizations.of(context)!.time_limit, style:TextStyle(fontStyle:FontStyle.italic),),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text(AppLocalizations.of(context)!.seconds_left, style:TextStyle(fontStyle: FontStyle.italic),),

                  const SizedBox(width: 5,),
                  Container(
                    width:100,
                    height: 100,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Center(child: Transform.scale(scale: 2.0, child: const CircularProgressIndicator(value: 1, valueColor: AlwaysStoppedAnimation(Color(0xFFf7f5f0)),))),
                        Center(child: Transform.scale(scale: 2.0, child: CircularProgressIndicator(value: timeLeft.toDouble()/maxTime, valueColor: const AlwaysStoppedAnimation(Colors.green),))),

                        Center(child: Text(timeLeft.toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22))),
                      ],
                    ),
                  )
                ],
              ),

              const SizedBox(height: 10),
              Expanded(
                child: GridView.builder(
                  itemCount: widget.candidates.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0
                  ),
                  itemBuilder: (BuildContext context, int index){
                    return InkWell(
                      onTap: (){
                        isSelected = true;
                        _index = index;
                        print(index);
                        setState((){

                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: (isSelected && index == _index)? isSelectedColor: const Color(0xFFf7f7f5)

                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Image.memory(base64Decode(widget.candidates[index]!.photo.toString()), width: 40, height: 40),
                            // const FadeInImage(width: 70, placeholder:AssetImage('assets/images/loading.png'), image: NetworkImage("https://icon-library.com/images/political-icon/political-icon-0.jpg"))

                            Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(50)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: ClipRRect(borderRadius: BorderRadius.circular(50), child:candidateImages[index]),
                              ),
                            ),

                            const SizedBox(height: 13),
                            Text(widget.candidates[index].name.toString(), style: headline7,)
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 15,),
              Button(tap: (){
                showDialog(barrierColor: Colors.grey.withOpacity(0.6), barrierDismissible: false, context: context, builder: (context){
                  return AlertDialog(title: const Row(children: [ Icon(Icons.how_to_vote, size: 25,), SizedBox(width: 5), Text('Confirmation')],),
                  content: Text(AppLocalizations.of(context)!.confirm_vote),
                  actions: [

                    Row(
                      children: [
                        SizedBox(
                          width: 120,
                          child: Button(tap: (){
                            Navigator.pop(context);
                          }, text: AppLocalizations.of(context)!.cancel.toUpperCase(), color:Colors.red, fontSize: 15, borderRadius: 10,),
                        ),

                        const SizedBox(width: 10),

                        SizedBox(
                          width: 120,
                          child: Button(tap: (){

                            voteProvider.vote(context: context, index: _index!, electionId: widget.electionId);

                            Future.delayed(const Duration(seconds: 5));

                            setState((){
                              voted = true;
                              timeLeft = 0;
                            });
                          }, text: AppLocalizations.of(context)!.confirm, color: primaryColor, fontSize: 15, borderRadius: 10,),
                        ),
                      ],
                    )
                  ],);
                });
              }, text: "SUBMIT", color: primaryColor, borderRadius: 10, fontColor: Colors.white,fontSize: 18),
              const SizedBox(height: 5,),
            ]
          )),
            ),);
    
  }
}