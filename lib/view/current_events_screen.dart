import 'package:flutter/material.dart';
import 'package:electa/components/custom_app_bar.dart';
import 'package:electa/models/elections_model.dart';
import 'package:electa/utils/app_colors.dart';
import 'package:electa/view/election_screen.dart';
import 'package:electa/view_model/election_provider.dart';
import 'package: intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CurrentEventsScreen extends StatefulWidget {
    const CurrentEventsScreen({Key? key}): super(key:key);

    @override
    State<CurrentEventsScreen> createState() => _CurrentEventsScreenState();
}

class _CurrentEventsScreenState extends State<CurrentEventsScreen> {

    @override

    void initState(){
        super.initState();
    }

    String formData(date){
        DateTime dateTime = DateTime.parse(date);
        DateTime dateTimeInRwanda = dateTime.add(Duration(hours:2));

        String formattedDate = DateFormat('dd MM yyyy').format(dateTimeInRwanda);
        return formattedDate;
    }

    String formatTime(date){
        DateTime dateTime = DateTime.parse(date);
        DateTime dateTimeInRwanda = dateTime.add(Duration(hours:2));
        String formattedTime = DateFormat().add_jm().format(dateTimeInRwanda);
        return formattedTime;
    }

    @override

    Widget build(BuildContext context){
        final electionProvider = Provider.of<ElectionProvider>(context);
        return Scaffold(
            appBar: customAppBar(title: AppLocalizations.of(context)!.ongoing_events, context: context),
            body: SafeArea(
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                        children: [

                            Expanded(
                                child: FutureBuilder(
                                    future: electionProvider.getElections(),
                                    builder: (context, snapshot){
                                        if(snapshot.connectionState == ConnectionState.waiting){
                                            return const Center(child: CircularProgressIndicator());
                                        } else if(snapshot.hasError){
                                            return Center(child: Text('Error: ${snapshot.error}'));
                                        } else {
                                            return ListView.builder(
                                                itemCount: electionProvider.elections.length,
                                                itemBuilder: (context, index){
                                                    final election= electionProvider.elections[index];
                                                    print("Elections: ${election.status}");
                                                    if(election.status == "in progress"){
                                                        return Padding(
                                                            padding: const EdgeInsets.only(bottom: 10.0),
                                                            child: Material(
                                                                elevation: 6,
                                                                borderRadius: BorderRadius.circular(6.0),
                                                                child: Container(
                                                                    width: double.infinity,
                                                                    height: 194,
                                                                    decoaration: BoxDecoration(
                                                                        color: Colors.white,
                                                                        borderRadius: BorderRadius.circualr(6.0),
                                                                    ),
                                                                    child: Column(
                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                        crossAxisAlignment: CrossAxisAlignmet.start,
                                                                        children: [

                                                                            // Expanded(
                                                                            //     child: ListView.builder( itemCount: election.candidates!.length, itemBuilder: (context, index){
                                                                            //         return Text(election.candidates![index].toString());
                                                                            //     }),
                                                                            // ),

                                                                            Padding(
                                                                                padding: const EdgeInsets.all(12.0),
                                                                                child: Column(
                                                                                    mainAxisAlignment: ManAxisAlignment.start,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                        Text(
                                                                                            election.title ?? '',
                                                                                            style: const TextStyle(
                                                                                                color: Colors.green,
                                                                                                fontWeight: FontWeight.bold,
                                                                                                fontSize: 22,
                                                                                            ),
                                                                                        ),
                                                                                        const SizedBox(height: 5,),
                                                                                        Text(
                                                                                            'Start Date : ${formatDate(election.startDate ?? '')} ${formatTime(election.startDate ?? '')}',
                                                                                            style: const TextStyle(
                                                                                                fontSize: 16,
                                                                                                fontWeight: FontWeight.w500,
                                                                                                color: Colors.black
                                                                                            ),
                                                                                        ),
                                                                                        const SizedBox(height: 5),
                                                                                        Text(
                                                                                            'End Date: ${formatDate(election.endDate ?? '')} ${formatTime(election.endDate ?? '')}',
                                                                                            style: const TextStyle(
                                                                                                fontSize: 16,
                                                                                                fontWeight: FontWeight.w500,
                                                                                                color: Colors.black
                                                                                            ),

                                                                                        ),
                                                                                        const SizedBox(height: 5),
                                                                                        Text(
                                                                                            'Status: ${election.status?.toUpperCase() ?? ''}',
                                                                                            style: TextStyle(
                                                                                                fontSize: 16,
                                                                                                fontStyle: FontStyle.italic,
                                                                                                color: Colors.grey.shade600,
                                                                                                fontWeight: FontWeight.w500,
                                                                                            ),
                                                                                        ),
                                                                                    ],
                                                                                ),
                                                                            ),

                                                                            Expanded(
                                                                                child:
                                                                                InkWell(
                                                                                    onTap: (){
                                                                                        Navigator.push(context, MaterialPageRoute(builder: (context)=> ElectionScreen(electionId: election.d, title: election.title.toString(), year: DateFormat('yyyy').format(DateTime.parse(election.startDate ?? '')), startDate: formatDate(election.startDate), startTime: formatTime(election.startDate), endTime: formatTime(election.endDate), status: election.status.toString(), candidates: election.candidates as List<Candidates>)));
                                                                                    },
                                                                                    child: Container(
                                                                                        width: double.infinity,

                                                                                        decoration: BoxDecoration(
                                                                                            color: primaryColor,
                                                                                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(6), bottomRight: Radius.circular(6))
                                                                                        ),
                                                                                        child: Center(
                                                                                            child: Container(
                                                                                                width: 41,
                                                                                                height: 41,
                                                                                                decoration: BoxDecoration(
                                                                                                    borderRadius: BorderRadius.circular(50),
                                                                                                    color: primaryColor
                                                                                                ),
                                                                                                child: Lottie.asset('assets/animations/animation_arrow.json', height: 260, fit: BoxFit.fill, width: 300, repeat: true, frameRate: const FrameRate(100))
                                                                                                // Center(child: Icon(Icons.arrow_forward, color: primaryCol,)) 
                                                                                            ),
                                                                                        ),
                                                                                    ),
                                                                                )
                                                                            )
                                                                        ],
                                                                    ),
                                                                ),
                                                            ),
                                                        );
                                                    }
                                                    else {
                                                        return Container();
                                                    }
                                                },
                                            );
                                        }
                                    },
                                ),
                            ),
                        ],
                    ),
                ),
            ),
        );
    }
}