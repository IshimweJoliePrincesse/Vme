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



    Future<void>getById()async {

      try{

        WidgetsFlutterBinding.ensureInitialized();

        SharedPreferences sp= await sharedPreferences.getInstance();
        final id await sp.getString('voterId') ?? '';
        print(id);
        final response = await http.get(Uri.parse('${androidURL}voter/${id}'));

        if(response.statusCode == 200){
          user = jsonDecode(response.body)['voter'];

          setState((){

          });
        } 
        else {
          debugPrint(response.statusCode.toString());
        }
      } catch(e){
        debugPrint(e.toString());
      }
    }

    String formatDate(date){
      DateTime dateTime = DateTime.parse(date);
      DateTime dateTimeInRwanda = dateTime.add(Duration(hours: 2));

      String formattedDate = DateFormat('dd mm yyyy').format(dateTimeInRwanda);
      return formattedDate;
    }

    String formatTime(date){
      DateTime dateTime = DateTime.parse(date);
      DateTime dateTimeInRwanda = dateTime.add(Duration(hours: 2));
      String formattedTime = DateFormat().add_jm().format(dateTimeInRwanda);
      return formattedTime;
    }

    @override

    void initState(){
      getById();
      super.initState();
    }

    @override

   Widget build (BuildContext context){

    final electionProvider = Provider.of<ElectionProvider>(context);
    final announcementProvider = Provider.of<AnnouncementProvider>(context);

    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[

              Expanded(
                flex: 3,
                child: Column(
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Row(
                          children: [

                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(color:const Color(0XFFf0f2f5),
                                borderRadius: BorderRadius.circular(50)
                              ),
                            child: ClipRect(

                              borderRadius: BorderRadius.circular(50),
                              child: user !=null ? Image.network(user['photo'], fit: BoxFit.fitWidth,):Image.asset('assets/images/user.png'),
                              //FadeInImage.assetNetwork(placeholderFit: BoxFit.scaleDown, fit: BoxFit.cover, placeholder: 'assets/images/loading_gif', image: user !=null ? user['photo']: '' //CupertinoActivityIndicator())
                            )
                            ),

                            const SizedBox(width: 7,),
                            Text("Hi! ${user != null ? user['name']: 'loading...'}", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),),
                          ],
                        ),

                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const SettingScreen()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: primaryColoe,
                              color: const Color(0XFFf0f2f5),

                              borderRadius: BorderRadius,circular(10)
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Icon(Icons.settings, color: Colors.white,),
                            ),
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 20,),

                    CarouselSlider(
                      options: CarouselOptions(height: 120.0, enlargeCenterPage: true, enlargeFactor: 0.3, scrollDirection: Axis.horizontal, initialPage: 1, autoPlay: true, autoPlayCurve: Curves.fastOutSlowIn, autoPlayAnimation: Duration(seconds: 2), autoPlayInterval: Duration(seconds: 6)),
                      items: [{'id':'Results', 'color': Colors.deepPurple, 'title': AppLocalizations.of(context)!.results, 'icon': Icons.bar_chart_outlined}, {'id': 'Election', 'color': Colors.blueAccent, 'title': AppLocalizations.of(context)!.elections, 'icon':Icons.how_to_vote_outlined }, {'id': 'Ongoing', 'color': Colors.deepPurpleAccent, 'title':AppLocalizations.of(context)!.ongoing_events, 'icon': Icons.poll_sharp}, {'id': 'Announcements', 'color': Colors.greenAccent, 'title': AppLocalizations.of(context)!.announcements, 'icon': Icons.announcement_outlined}, {'id': 'Parties', 'color': Colors.orange, 'title':AppLocalizations.of(context)!.official_parties, 'icon':Icons.people_alt_sharp}].map((i){
                        return Builder(
                          builder: (BuildContext context){
                            return InkWell(
                              onTap: (){

                                switch(i['id']){
                                  case 'Results':
                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>const ResultsScreen()));
                                   break;
                                  case 'Elections':
                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>const UpcomingEventScreen()));
                                   break;
                                  case 'Ongoing':
                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>const CurrentEventsScreen()));
                                   break;
                                  case: 'Announcements':
                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>const NewsAnnouncementsScreen()));
                                   break;
                                  case 'Parties':
                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>const PoliticalPartiesScreen()));
                                   break;

                                }


                              },
                            )
                          }
                        )
                      })
                    )
                  ]
                )
              )
            ]
          )
        )
      )
    )
   }
}