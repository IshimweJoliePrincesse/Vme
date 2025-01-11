import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:electa/components/button.dart';
import 'package:electa/components/input_field.dart';
import 'package:electa/utils/app_colors.dart';
import 'package:electa/utils/app_styles.dart';
import 'package:electa/utils/constants.dart';
import 'package:electa/view/camera_screen.dart';
import 'package:electa/view/complete_profile.dart';
import 'package:electa/view/home_screen.dart';
import 'package:electa/view/login_official_screen.dart';
import 'package:electa/view/official_view/change_password_screen.dart';
import 'package:electa/view/setting_screen.dart';
import 'package:electa/view_model/theme_mode_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, this.auth = false});

  final bool auth;

  @override
  State<LoginScreen> createState() =>_LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {

  TextEditingController idController = TextEditingController();
  bool checkBoxValue = false;
  bool isLoading = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> login() async {

    try{
      if(idController.value.text !=''){
        if(idController.value.text.length <=16){
          final response = await http.post(
            Uri.parse('http://192.168.100.26:5000/login'), headers: {
              'Content-Type' : 'application/json',
            }, body: jsonEncode({
              'id' : idController.value.text.trim(),
            })
          );
          debugPrint(response.statusCode.toString());
          if(response.statusCode == 200){

            var data = jsonDecode(response.body);

            print(data['token']);
            final token = data['token'].toString();
            final id = data['user']['_id'].toString();
            final name = data['user']['name'].toString();
            SharedPreferences sp = await SharedPreferences.getInstance();
            await sp.setString('token', token);
            await sp.setString('voterId', id);
            await sp.setString('name', name);


            final isProfileCompleted = sp.getBool('profile_completed') ?? false;
            if(isProfileCompleted){
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> const HomeScreen()), (route)=>false);
            }
            else{
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                builder: (context) => const CompleteProfile()
              ), (
                route
              )=> false);
            }

            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('User Login Successfully'),
            ));
          }
          else{
            debugPrint('Login Failed, status code: ${response.statusCode.toString()}');

            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("User Login Failed"),
              backgroundColor: Colors.red,
            ));
          }
        } else{
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('ID must contain 16 digits'),
            backgroundColor: Colors.red,
          ));
        }
      }
        else{
          debugPrint('Please enter correct ID');
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Please enter correct ID'), backgroundColor: Colors.red
          ));
        
      }
    }
    catch(e){
      debugPrint('Error Occurred $e');
    }
  }

  String? loginValidation(value){

    debugPrint(idController.text.length.toString());

    if(value.isEmpty){
      return 'Please enter ID';
    }
    if(value.contains('-')){
      return 'ID must be without dashes';
    }
    if(value.length !=16){
      return 'ID must consist of 16 digits';
    }
    return null;
  }

  @override
  Widget build(BuildContext context){

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomRight,
          colors: [
            Color(0XFF2BAC13),
            Color(0XFF0E530E),
          ]
        )
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      const Image(image: AssetImage('assets/images/logo.png'), width: 100,),
                      const SizedBox(height: 15,),
                      Center(child: Text(appName, style: headline1)),
                    ],
                  ),
                ),

                const SizedBox(height: 40,),

                Expanded(

                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Provider.of<ThemeModeProvider>(context).themeMode == ThemeMode.light ? Colors.white: const Color(0XFF212121),
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Column(
                              children: [
                                Text(AppLocalizations.of(context)!.login_account, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w500),),
                                Text(AppLocalizations.of(context)!.please_sign_in_to_continue, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                              ],
                            ),
                          ),
                          Form(autovalidateMode: AutovalidateMode.onUserInteraction, key: formKey, child: Padding(padding: const EdgeInsets.all(0.0), child: InputField(controller: idController, hintText: AppLocalizations.of(context)!.enterID, icon:Icons.account_circle, validator: loginValidation,))),

                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: widget.auth ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 66,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.check_circle, color: Colors.white,), const SizedBox(width: 5), Text('FACE VERIFIED', style: headline4,),]),
                              ),
                            ):
                            Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                              child: Button(tap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const CameraScreen()));

                              }, text: AppLocalizations.of(context)!.verifyFace, color: Colors.green, fontColor: Colors.white, fontSize: 18, borderRadius: 50.0),
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Checkbox(value: checkBoxValue, activeColor: Colors.green, splashRadius: 30, side: const BorderSide(color: Colors.green), onChanged: (val){
                                checkBoxValue = val!;
                                setState((){});
                              }),
                              Text(AppLocalizations.of(context)!.agree_to_our_terms_conditions,),
                            ],
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 13),
                            child: Button(tap: ()async{

                              setState((){
                                isLoading = true;
                              });
                              await Future.delayed(const Duration(seconds: 2));
                              setState((){isLoading = false;});

                              if(widget.auth){
                                if(checkBoxValue){
                                  login();
                                }
                                else{
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Agree to our terms & conditions"), backgroundColor: Colors.red,));
                                }
                              } else{
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Verify face in order to login"), backgroundColor: Colors.red,));
                              }
                              setState((){

                              });


                            }, text: AppLocalizations.of(context)!.login, color: primaryColor, fontColor: Colors.white, fontSize: 18, borderRadius: 10.0, loading:isLoading,),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center, 
                              children: [
                                Text(AppLocalizations.of(context)!.officialMember,),
                                const SizedBox(width: 5,),
                                InkWell(onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginOfficialScreen()));
                                }, child: Text(AppLocalizations.of(context)!.login, style: const TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline),)),
                              ],
                            ),
                          )
                        ],
                      ),
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
}