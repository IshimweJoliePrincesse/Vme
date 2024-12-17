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
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                  color: i['color'] as Color,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Center(child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(i['icon'] as IconData, size: 40, color: Colors.white,),
                                    Text('${i['title']}', textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0, color: Colors.white),),
                                  ],
                                ))
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),


                    const SizedBox(height: 20,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        InkWell(

                          onTap: (){
                            setState((){
                              status = 'all';
                              statusIndex = 0;
                              selectedStatusIndex = statusIndex;
                            });
                          },
                          child: Container(
                            width: 100,
                            decoration: BoxDecoration(
                              color: status == 'all' ? primaryColor: Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: primaryColor),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(child: Text('All', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: status == 'all' ? Colors.white: Colors.grey.shade600,),)),
                            ),
                          ),
                        ),

                        InkWell(
                          onTap: (){
                            setState((){
                              status = 'ongoing';
                              statusIndex = 1;
                              selectedStatusIndex = statusIndex;
                            });
                          },
                          child: Container(
                            width:100,
                            decoration: BoxDecoaration(
                              color: status == 'ongoing' ? primaryColor: Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: primaryColor)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(child: Text('Ongoing', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: status == 'ongoing' ? Colors.grey.shade600,),)),
                            ),
                          ),
                        ),

                        InkWell(
                          onTap: (){
                            setState((){
                              status='upcoming';
                              statusIndex = 2;
                              selectedStatusIndex = statusIndex;
                            });
                          },
                          child: Container(
                            width: 100,
                            decoration: BoxDecoration(
                              color: status == 'upcoming' ? primaryColor: Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: primaryColor)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(child: Text('Upcoming', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: status == 'upcoming' ? Colors.white: Colors.grey.shade600,),)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: FutureBuilder(
                        future: electionProvider.getElections(),
                        builder: (context, snapshot){
                          if(snapshot.connectionState == ConnectionState.waiting){
                            return const Center(child: CircularProgressIndicator(),);
                          }
                          else if(snapshot.hasError){
                            return Center(child: Text('Error: ${snapshot.error}'));
                          }
                          else {
                            return ListView.builder( itemCount: electionProvider.elections.length, itemBuilder:(context, index){
                              final elections = electionProvider.elections[index];

                              if(status == 'upcoming' && elections.status!.toLowerCase() == 'not started'){
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal:8.0),
                                  child:Material(
                                    elevation: 5,
                                    borderRadius: BorderRadius.circular(5),
                                    child: Container(
                                      width: double.infinity,

                                      decoration: BoxDecoration(
                                        color: Color(0xffafcfb),

                                        borderRadius: BorderRadius.circular(5)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          
                                          children:[
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children:[
                                                Text("${elections.title} ${DateFormat('yyyy').format(DateTime.parse(elections.startDate.toString()))}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.black),),
                                                Text("Date: ${DateFormat('dd MM yyyy').format(DateTime.parse(elections.startDate.toString()))}", style:TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),),
                                              ],
                                            ),

                                            if(formatDate(elections.startDate)==DateFormat('dd MM yyyy').format(DateTime.parse(DateTime.now().toString())))
                                            InkWell(
                                              onTap: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ElectionsScreen(electionId: elections.id, title: elections.title.toString(), year: DateFormat('yyyy').format(DateTime.parse(elections.startDate ?? '')), startDate: formatDate(elections,startDate), startTime: formatTime(elections.startDate), endTime: formatTime(elections.endDate), status: elections.status.toString(), candidats: elections.candidates as List<Candidate>)));
                                              },
                                              child: Container(
                                                width: 75,
                                                decoration: BoxDecoration(
                                                  color: primaryColor,
                                                  borderRadius: BorderRadius.circular(6),
                                                  border: Border.all(color: primaryColor)
                                                ),
                                                child: const Padding(
                                                  padding: EdgeInsets.all(3.0),
                                                  child: Center(child: Text('Start', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white),)),
                                                ),
                                              ),

                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } //&& elections.status!.toLoweCase() == 'in progress'
                              else if(status == 'ongoing' && elections.status!.toLowerCase() == 'in progress'){

                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Material(
                                    elevation: 5,
                                    borderRadius: BorderRadius.circular(8),
                                    child: Container(
                                      width: double.infinity,

                                      decoration BoxDecoration(
                                        color: const Color(0xFFfafcfb),

                                        borderRadius: BorderRadius.circular(8)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children:[
                                                Text("Date: ${DateFormat('yyyy').format(DateTime.parse(elections.startDate.toString()))}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold, fontSize: 17, color: Colors.black
                                                ),),
                                                Text("Date: ${DateFormat('dd MM yyyy').format(DateTime.parse(elections.startDate.toString()))}",
                                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
                                                ),
                                                Text("Status: ${elections.status?.toUpperCase()}", style:TextStyle(fontStyle: FontStyle.italic, color: Colors.grey.shade600, fontWeight: FontWeight.w500),)
                                              ],
                                            ),
                                          InkWell(
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ElectionScreen(electionId: elections.id, title:elections.title.toString(), year: DateFormat('yyyy').format(DateTime.parse(elections.startDate ?? '')), startDate: formatDate(elections.startDate), startTime: formatTime(elections.startDate), endTime: formatTime(elections.endDate), status: elections.status.toString(), candidates: elections.candidates as List<Candidates>)));
                                            },
                                            child: Container()(
                                              width: 75,
                                              decoration: BoxDecoration(
                                                color: primaryColor,
                                                borderRadius: BorderRadius.circular(6),
                                                border: Border.all(
                                                  color: primaryColor
                                                )
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.all(3.0),
                                                child: Center(child: Text('Start', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white),)),
                                              ),

                                            ),
                                          )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                              else if(status == 'all'){
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                                  child: Material(
                                    elevation: 5,
                                    borderRadius: BorderRadius.circular(5),
                                    child: Container(
                                      width: double.infinity,

                                      decoration: BoxDecoration(
                                        color: Color(0xfffafcfb),

                                        borderRadius: BorderRadius.circular(5)
                                      ),
                                      child: Padding(
                                        padding:const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children:[
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children:[
                                                Text("${elections.title} ${DateFormat('yyyy').format(DateTime.parse(elections.startDate.toString()))}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.black),)
                                                Text("Date: ${DateFormat('dd MM yyyy').format(DateTime.parse(elections.startDate.toString()))}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),),
                                              ],
                                            ),

                                            elections.status == 'in progress' ?
                                            InkWell(
                                              onTap: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ElectionScrenn(electionId: elctions.id, title: elections.title.toString(), year: DateFormat('yyyy').format(DateTime.parse(elections.startDate ?? '')), startDate: formatDate(elections.startDate), startTime: formatTime(elections.startDate), endTime: formatTime(elections.endDate), status: elections.status.toString(), candidates: elections.candidates as List<Candidates> )));
                                               },
                                               child: Container(
                                                width: 75,
                                                decoration: BoxDecoration(
                                                  color: primaryColor,
                                                  borderRadius: BorderRadius.circular(6),
                                                  border: Border.all(color: primaryColor)
                                                ),
                                                child: const Padding(
                                                  padding: EdgeInsets.all(3.0),
                                                  child: Center(child: Text('Start', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white),)),
                                                ),
                                               ),
                                               ): Container(),
                                          ],
                                            ),
                                      ),
                                          
                                        ),
                                      ),
                                    ),
                              } else {
                                return Container();
                              }
                            });
                               
                              }

                            }
                      )
                    ),
                      
                      
                  ],
                ),
              ),

              const SizedBox(height: 20,),
              Text(AppLocalizations.of(context)!.news_updates, style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),),
              const SizedBox(height: 7,),
              Expanded(

                child: FutureBuilder(
                  future: announcementProvider.getPost(),
                  builder: (context, snapshot){
                    if(snapshot.hasData){
                      return const Center(child: const CircularProgressIndicator());
                    }
                    else if(snapshot.hasError){
                      return Text("Something went wrong");
                    }
                    else {
                      return ListView.builder(scrollDirection: Axis.vertical,
                      itemCount: announcementProvider.postList.length,
                      itemBuilder: (context, index){
                        return
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              width: double.infinity,
                              height: 145,
                              decoartion: BoxDecoration(
                                color: Colors.white,

                                borderRadius: BorderRadius.circular(5)
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(100))
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0, right: 8, left: 3.5, top: 3.5),
                                      child: Icon(Icons.star, color: Colors.white, size: 18,),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
                                    child: Column(
                                      children:[

                                      Text(DateFormat('dd MM yyyy').format(DateTime.parse(announcementProvider.postList[index]['date'].tString())), style: TextStyle(color: Colors.black54),),

                                      InkWell(
                                        onTap: (){

                                        },
                                        child: Row(
                                          children: [
                                            Icon(Icons.attachment),
                                            SizedBox(width: 4,),
                                            Text('img.jpg', style: TextStyle(color: primaryColor, fontStyle: FontStyle.italic),)
                                          ]
                                        )
                                      )
                                      ]
                                    )
                                  )
                                ]
                              )
                            )
                          )
                        )
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