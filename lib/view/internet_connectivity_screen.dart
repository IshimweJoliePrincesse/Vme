// import 'dart:async';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:electa/components/snack.dart';
// import 'package:electa/utils/app_styles.dart';
// import 'package:electa/view/home_screen.dart';
// import 'package:electa/view/login_screen.dart';
// import 'package:electa/view/setting_screen.dart';
// import 'package:electa/view/splash_screen.dart';

// class InternetConnectivityScreen extends StatefulWidget {
//   const InternetConnectivityScreen({super.key});

//   @override
//   State<InternetConnectivityScreen> createState() =>_InternetConnectivityScreenState();
// }

// class _InternetConnectivityScreenState extends State<InternetConnectivityScreen> {

//   Connectivity connectivity = Connectivity();
//   late StreamSubscription streamSubscription;
//   bool isConnected = false;

//   @override
//   void initState(){
//     super.initState();
//     internetConnectivity();
//   }

//   checkInternetConnection() async {
//     var result await connectivity.checkConnectivity();
    
//     if(result== ConnectivityResult.none){

//       isConnected = false;
//       print('Not Connected');
//       ScaffoldMessenger.of(context).showMateralBanner(MaterialBanner(backgroundColor: Colors.red, content: Text("Check Internet Connection...", style: headline3,), actions: const [CupertinoActivityIndicator(color: Colors.black)]));
//       //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Internet not available"), duration: Duration(seconds: 3), ));
//     }
//     else{
//       isConnected = true;
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Internet connection established"), duration: Duration(seconds: 4),));
//       ScaffoldMessenger.of(context).hideCurrentMaterialBanner(reason: MaterialBannerClosedReason.dismiss);
//     }
//     setState((){});
//   }

//   internetConnectivity(){
//     streamSubscription= connectivity.onConnectivityChanged.listen((event) async {
//       checkInternetConnection();
//     });
//   }

//   @override
//   Widget build(BuildContext context){
//     return const SettingScreen();
//   }
// }


// class InternetConnectionWidget extends StatelessWidget {
//   const InternetConnectionWidget({Key? key, required this.snapshot, required this.widget});

//   final AsyncSnapshot<ConnectivityResult> snapshot;
//   final Widget widget;

//   @override
//   Widget build(BuildContext context){
//     switch (snapshot.connectionState){
//       case ConnectionState.active:
//       final state = snapshot.data!;
//       switch(state){
//         case ConnectivityResult.none:
//         return const Center(child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Center(
//               child: Column(
//                 children: [
//                   Icon(Icons.wifi_off_rounded, size: 35,),
//                   Text("Internet not Available", style: TextStyle(
//                     fontSize: 20, fontWeight: FontWeight.w500, color: Colors.green
//                   ),)
//                 ],
//               ),
//             )
//           ],
//         ),);
//         default:
//          return widget;
//       }
//       case ConnectionState.none: //Handle ConnectionState.none
//       return Center(child: Text("Connection State: None"));
//       Cae ConnectionState.waiting: //Handle ConnectionState.waiting
//       return Center(child: CircularProgressIndicator());
//       case ConnectionState.done: //Handle ConnectionState.done
//       return Center(child: Text("Connection state:Done"));
//       default: //Handle any other ConnectionState
//       return Center(child: Text("Connection State: ${snapshot.connectionState}"));
//     }
//   }
// }

import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:electa/utils/app_styles.dart';

class InternetConnectivityWrapper extends StatefulWidget {
  final Widget child;

  const InternetConnectivityWrapper({Key? key, required this.child}): super(key: key);

  @override
  _InternetConnectivityWrapperState createState()=>_InternetConnectivityWrapperState();
}
  class _InternetConnectivityWrapperState extends State<InternetConnectivityWrapper>{
    Connectivity connectivity = Connectivity();
    late StreamSubscription streamSubscription;
    bool isConnected = true;

    @override

    void initState(){
      super.initState();
      internetConnectivity();
    }

    checkInternetConnectivity() async {
      var result = await connectivity.checkConnectivity();

      if(result == ConnectivityResult.none){
        setState((){
          isConnected = false;
        });
        ScaffoldMessenger.of(context).showMaterialBanner(
          MaterialBanner(
            backgroundColor: Colors.red,
            content: Text(
              "Check Internet Connection...",
              style: headline3,
            ),
            actions: const [CupertinoActivityIndicator(color: Colors.black)],
          ),
        );
      } else {
        setState((){
          isConnected = true;
        });
        ScaffoldMessenger.of(context).hideCurrentMaterialBanner(reason: MaterialBannerClosedReason.dismiss);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Internet connection established"),
            duration: Duration(seconds: 4),
          ),
        );
      }
    }

    internetConnectivity(){
      streamSubscription = connectivity.onConnectivityChanged.listen((event) async{
        await checkInternetConnection();
      });
    }

    @override

    void dispose(){
      streamSubscription.cancel();
      super.dispose();
    }

    @override

    Widget build(BuildContext context){
      return Scaffold(
        body: Stack(
          children: [
            widget.child,
            if(!isConnected)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 60,
                color: Colors.black87,
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    SizedBox(width: 8),
                    Icon(Icons.wifi_off, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      "No internet Connection",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
