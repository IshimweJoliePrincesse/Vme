import 'package:flutter/material.dart';
import 'package:electa/components/custom_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  late WebViewController controller;

  @override
  void initState() {
    loadPage();

    super.initState();
  }

  void loadPage() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.disabled)
      ..loadRequest(Uri.parse(
          'https://www.freeprivacypolicy.com/live/1874681f-7992-4955-a6df-aed5dfbbbac0'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "About Us", context: context),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: WebViewWidget(controller: controller),
      ),
    );
  }
}
