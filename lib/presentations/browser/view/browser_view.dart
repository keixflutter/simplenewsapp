import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BrowserView extends StatelessWidget {
  final String uri;
  const BrowserView({super.key, required this.uri});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebViewWidget(
          controller: WebViewController()..loadRequest(Uri.parse(uri))),
    );
  }
}
