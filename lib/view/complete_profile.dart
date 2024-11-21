import 'package:flutter/material.dart';
import 'package:electa/components/button.dart';
import 'package:electa/components/custom_app_bar.dart';
import 'package:electa/components/label_input_field.dart';
import 'package:electa/utils/app_colors.dart';
import 'package:electa/utils/app_styles.dart';
import 'package:electa/components/input_field.dart';
import 'package:electa/utils/constants.dart';
import 'package:electa/view/home_screen.dart';
import 'package:electa/view/official_view/profile.dart';
import 'package:electa/view_model/profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({super.key});

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {

  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isPressed = false;

  @override

  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return Scaffold(
      appBar: customAppBar(context: context, title: 'Complete Profile'),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40,),
                Text('Complete Your Profile', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),),
                const Text("Firstly, Complete your profile inorder to continue."),
                const SizedBox(height: 30,),

                Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child:
                Column(
                  children: [
                    LabelInputField(controller: phoneController,label: "Phone",icon: Icon(Icons.phone), validator: (value) {

                      if(value!.isEmpty){
                        return 'Phone required*';
                      }
                      if(value!.length < 10 || value!.lenght > 13){
                        return "Invalid phone number";
                      }
                      return null;
                    } ,),

                    LabelInputField(controller: emailController, label: "Email", icon: Icon(Icons.email), validator: (value) {

                      if(value!.isEmpty){
                        return "Email required*";
                      } 
                      if(!RegExp(emailRegExp).hasMatch(value)){
                        return "Invalid email";
                      }

                      return null;
                    },),
                  ],
                )
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Button(tap: () async {


                    if(formKey.currentState!.validate()){

                      isPressed = true;
                      Future.delayed(const Duration(seconds: 5));

                      profileProvider.updateProfile(
                        context, phoneController.text, emailController.text
                      );

                      SharedPreferences sp = await SharedPreferences.getInstance();
                      await sp.setBool('profile_completed', true);

                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> const HomeScreen()), (route)=> false);
                    }
                  }, text: "NEXT", color: primaryColor, fontSize: 20, fontColor: whiteColor, borderRadius: 10,),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}