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
      appBar: customAppBar(
          title: AppLocalizations.of(context)!.contactUs, context: context),
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            const Expanded(
                flex: 0,
                child: SizedBox(
                    width: 200,
                    child:
                        Image(image: AssetImage('assets/images/contact.png')))),
            Expanded(
              flex: 1,
              child: Form(
                key: _key,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Container(
                  decoration: BoxDecoration(
                      color:
                          Provider.of<ThemeModeProvider>(context).themeMode ==
                                  ThemeMode.light
                              ? whiteColor
                              : const Color(0xFF212121),
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 5, left: 8, right: 8),
                            child: Text(
                              AppLocalizations.of(context)!.how_we_help_you,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            )),
                        LabelInputField(
                          controller: emailController,
                          label: AppLocalizations.of(context)!.email,
                          placeholder: AppLocalizations.of(context)!.enterEmail,
                          maxLines: 1,
                          icon: const Icon(Icons.email),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email Required";
                            }
                            if (!RegExp(emailRegExp).hasMatch(value)) {
                              return "Invalid Email";
                            }
                          },
                        ),
                        LabelInputField(
                            controller: subjectController,
                            label: AppLocalizations.of(context)!.subject,
                            placeholder:
                                AppLocalizations.of(context)!.enterSubject,
                            maxLines: 1,
                            icon: const Icon(Icons.subject),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Subject Required";
                              }
                            }),
                        LabelInputField(
                            controller: messageController,
                            label: AppLocalizations.of(context)!.message,
                            placeholder:
                                AppLocalizations.of(context)!.enterMessage,
                            maxLines: 4,
                            icon: const Icon(Icons.message),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Message Required";
                              }
                            }),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Button(
                              tap: () {
                                if (emailController.text == '' ||
                                    subjectController.text == '' ||
                                    messageController.text == '') {
                                  showSnackBar(
                                      context: context,
                                      title: "All fields required");
                                } else {
                                  contactProvider.postContact(
                                      context,
                                      emailController.text.trim(),
                                      subjectController.text,
                                      messageController.text);
                                }
                              },
                              text: AppLocalizations.of(context)!.send,
                              color: primaryColor,
                              borderRadius: 10.0,
                              fontColor: whiteColor,
                              fontSize: 18),
                        ),
                        if (contactProvider.loading)
                          Center(child: CupertinoActivityIndicator())
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
