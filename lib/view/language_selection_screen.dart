import 'package:flutter/material.dart';
import 'package:electa/components/custom_app_bar.dart';
import 'package:electa/utils/app_colors.dart';
import 'package:electa/view_model/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageSelectionScreen extends StatefulWidget {
  LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState()=>_LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  int selectedOption = 1;

  @override

  Widget build(BuildContext context){
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      appBar: customAppBar(title: AppLocalizations.of(context)!.select_language, context: context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              ListTile(

                leading: Radio(value: 1, groupValue: selectedOption, onChanged: (val){
                  selectedOption = val!;
                  languageProvider.changeLanguage(const Locale('en'));
                  setState((){

                  });
                }),
                title: Text(AppLocalizations.of(context)!.english, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),),
              ),
              const Divider();
              ListTile(

                leading: Radio(value: 2, groupValue: selectedOption, onChanged: (val){
                  selectedOption = val!;
                  languageProvider.changeLanguage(const Locale('rw'));
                  setState((){

                  });
                }),
                title: Text(AppLocalizations.of(context)!.kinyarwanda, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
              ),
              const Divider();
            ],
          ),
        ),
      ),
    );

  }
}