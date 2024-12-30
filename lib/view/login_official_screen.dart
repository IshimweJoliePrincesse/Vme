import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:electa/components/button.dart';
import 'package:electa/components/input_field.dart';
import 'package:electa/components/snack.dart';
import 'package:electa/utils/app_colors.dart';
import 'package:electa/utils/app_styles.dart';
import 'package:electa/utils/constants.dart';
import 'package:electa/view/camera_screen.dart';
import 'package:electa/view/login_screen.dart';
import 'package:electa/view/official_view/official_home_screen.dart';
import 'package:electa/view/official_view/register_candidate_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:electa/view_model/auth_provider.dart';
import 'package:electa/view_model/theme_mode_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginOfficialScreen extends StatefulWidget {
  const LoginOfficialScreen({super.key});

  @override
  State<LoginOfficialScreen> createState() => _LoginOfficialScreenState();
}

class _LoginOfficialScreenState extends State<LoginOfficialScreen> {
  bool checkBoxValue = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override

  Widget build(BuildContext context){
    final authProvider = Provider.of<AuthProvider>(context);
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
                      const Image(
                        image: AssetImage("assets/images/logo.png"),
                        width: 100,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Center(child: Text(appName, style: headline1)),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Provider.of<ThemeModeProvider>(context).themeMode == ThemeMode.light ? Colors.white : const Color(0XFF212121),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0)
                      )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizonta: 10,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Column(
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.login_officially,
                                  style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                                Text(
                                  AppLocalizations.of(context)!.please_sign_in_to_continue,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400
                                  ),
                                ),
                              ],
                            )
                          ),
                          Form(
                            autoValidateMode:
                            AutovalidateMode.onUserInteraction,
                            key: formKey,
                            child: Column(
                              children: [
                                Paddin(
                                  padding: const EdgeInsets.all(0.0),
                                  child: InputField(
                                    controller: emailController,
                                    hintText:
                                    AppLocalizations.of(context)!.enterEmail,
                                    icon: Icons.email_rounded,
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return 'Please enter email';
                                      }
                                      if(!RegExp(emailRegExp).hasMatch(value)){
                                        return 'Please enter a valid email';
                                      }

                                      return null;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: InputField(
                                    controller: passwordController,
                                    hintText:
                                    AppLocalizations.of(context)!.enterPassword,
                                    icon: Icons.password_sharp,
                                    hideText: true,
                                    validator: (value){
                                      if (value!.isEmpty){
                                        return 'Please enter password';
                                      }
                                      if(value!.length < 10){
                                        return 'Password greater than 10 characters';
                                      }
                                      return null;
                                    },
                                  )
                                )
                              ],
                            )
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Checkbox(
                                value: checkBoxValue,
                                activateColor: Colors.green,
                                splashRadius: 30,
                                size: const BorderRadius(color: Colors.green),
                                onChanged: (val){
                                  checkBoxValue = val!;
                                  setState((){});
                                },
                              ),
                              Text(
                                AppLocalizations.of(context)!
                                .agree_to_our_terms_conditions,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,horizontal: 13.0
                            ),
                            child: Button(
                              tap: () async {
                                setState((){
                                  isLoading = true;
                                });
                                await Future.delayed(const Duration(seconds: 1));
                                setState((){
                                  isLoading = false;
                                });
                                if(formKey.currentState!.validate()){
                                  if(!checkBoxValue){
                                    //ignore: use_build_context_synchronously
                                    showSnackBar(context: context, title: " Agree to our terms & conditions", color:Colors.red);
                                    return;
                                  }
                                  //ignore: use_build_context_sybc_synchronously
                                  authProvider.officialLogin(context, emailController.text.trim(), passwordController.text.trim());
                                }
                              },
                              text: AppLocalizations.of(context)!.login.toUpperCase(),
                            )
                          )
                        ]
                      )
                    )
                  )
                )
              ]
            )
          )
        )
      )
    )
  }
}