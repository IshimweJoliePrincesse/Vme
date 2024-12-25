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
  final String status;
  final List<Candidates> candidates;

  @override
  State<ElectionScreen> createState() => _ElectionScreenState();
}

class _ElectionScreenState extends State<ElectionScreen> {
  bool started = false;
  bool ended = false;

  @override

  void initState(){


    if('16 April 2024' == formattedDate.toString()){
      if(currentTime.isAfter(comparisonTime)){
        print('current time is after 7:04 PM.');
        started = true;
      } else if(currentTime.isBefore(comparisonTime)){
        print('current time is before 7:04 PM.');
        started = false;
      } else {
        print('current time is 7:04 PM.')
        started = true;
      }
    }

    start();
    super.initState();
  }

  updateStatus({required id, required String status}) async {
    try{
      final response = await http.put(Uri.parse("${androidURL}update/status"),
      headers:{
        'Content-Type' : 'application/json'
      }, body: jsonEncode({
        'id' : id,
        'status' : status
      }));

      if(response.statusCode == 200){
        debugPrint("Status updated");
      } 
      else {
        debugPrint(response.statusCode.toString());
      }
    } catch(e){
      debugPrint(e.toString());
    }
  }

  void start(){


    String formattedDate= DateFormat('d MMMM yyyy', 'en-us').format(DateTime.now());
    String formattedTime = DateFormat('h:mm a').format(DateTime.now());

    DateTime currentTime = DateFormat('h:mm a').parse(formattedTime);
    DateTime comparisonTime = DateFormat('h:mm a').parse('7:15 PM');

    debugPrint(formattedDate);
    debugPrint(widget.startDate);
    debugPrint(widget.startTime);
    print(currentTime);

    print(DateFormat('h:mm a').parse("1:00 PM"));

    if(widget.startDate.toString() == formattedDate.toString()){
      if(currentTime == DateFormat('h:mm a').parse(widget.startTime)){
        started = True;
        updatedStatus(id: widget.electionId, status: 'in progress');
        setState((){

        });
      }
      else if (currentTime.isAfter(DateFormat('h:mm a').parse(widget.startTime)) && currentTime.isBefore(DateFormat('h:mm a').parse(widget.endTime))){
        print('Current time is before ${widget.startTime}');
        started = false;
        setState((){

        });
      }
      else if(currentTime == DateFormat('h:mm a').parse(widget.endTime) || currentTime.isAfter(DateFormat('h:mm a').parse(widget.endTime))){
        print('current time is after ${widget.endTime}');

        started = false;
        ended = true;
        updateStatus(id: widget.electionId, status: 'completed');

        Future.delayed(Duration.zero, (){
          Provider.of<VoteProvider>(context, listen: false).setVoted();
        });

        setState((){

        });
      }
      else {
        print('current time is ${widget.startTime}');
        started = false;
        setState((){

          // updateStatus(id: widget.electionId, status: 'completed');

        });
      }

      debugPrint(started.toString());
    }
  }

  @override

  Widget build(BuildContext context){
    final voteProvider = Provider.of<VoteProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Material(
                  elevation: 7,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: double.infinity,
                    height: 240,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
                    ),
                    child: SafeArea(
                      child: Stack(
                        children: [
                          const ClipRRect(
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                            child: SizedBox(
                              width: double.infinity,
                              height: double.infinity,
                              child: Image(image: AssetImage('assets/images/flag.jpg'), fit: BoxFit.cover,),
                            ),
                          ),

                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('${widget.title}\n${widget.year}', textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 30, color: Colors.white),)

                              ],
                            ),
                          ),

                          IconButton(onPressed: (){
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white,),),
                        ]
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[
                          const Icon(Icons.access_time_outlined),
                          const SizedBox(width: 5),
                          Text("Voting starts at ${widget.startTime} ${widget.startDate}", style: const TextStyle(fontSize: 16),)

                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.calendar_month),
                          const SizedBox(width: 5,),
                          Text(widget.status == 'not started'? 'currently unavailaable' : 'currently available', style: const TextStyle(fontSize: 15),)
                        ],
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      Lottie.asset('assets/animations/animation_voting.json', height: 220, fit: BoxFit.fill, width: 300, repeat: false, frameRate: const FrameRate(100)),
                      Text("Standing Candidates", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),),
                      Container(
                        height: 130,
                        child: Column(
                          children: [Expanded(
                            flex: 1,
                            child: ListView.builder(itemCount: widget.candidates.length, itemBuilder: (context, index){
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text(widget.candidates[index].name.toString(), style: TextStyle(fontWeight: FontWeight.w500, color:Colors.black),),
                                  )
                                ),
                              );
                            }),
                          ),]
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
              child: Button(tap: (){

                start();
                setState((){

                });

                if(ended == true){
                  ScaffoldMessenger.of(context).showSnackbar(const SnackBar(content: Text('Voting has not been ended')));
                  return;
                }
                if(voteProvider.isVoted == false){
                  if(started== false){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Voting has not yet started')));
                  }else{
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context)=>
                        DigitalBallotScreen(electionId: widget.candidates)
                      )
                    );
                  }

                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('You have already voted!')));
                }
              }, text: 'Start', color: primaryColor, fontSize: 18, borderRadius: 10,),
            )
          ],
        ),
      ),
    );
  }
}