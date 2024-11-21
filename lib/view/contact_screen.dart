import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:electa/components/button.dart';
import 'package:electa/components/custom_app_bar.dart';
import 'package:electa/components/label_input_field.dart';
import 'package:electa/components/snack.dart';
import 'package:electa/utils/app_colors.dart';
import 'package:electa/utils/constants.dart';
import 'package:electa/view_model/contact_provider.dart';
import 'package:electa/view_model/theme_mode_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override

  Widget build(BuildContext context) {
    final contactProvider = Provider.of<ContactProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: customAppBar(title: AppLocalizations.of(context)!.contactUs, context: context),
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            const Expanded(
              flex: 0,
              child: SizedBox(
                width: 200,
                child:
                   Image(image: AssetImage('assets/images/contact.png'))
              )
            ),
            Expanded(
              flex: 1,
              child: Form(
                key: _key,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Container(
                  decoration: BoxDecoration(
                    color: Provider.of<ThemeModeProvider>(context).themeMode == ThemeMode.light ? whiteColor: const Color(0xFF212121),
                    
                  )
                )
              )
            )
          ]
        )
      )
    )
  }
}