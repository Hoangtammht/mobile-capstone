import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RechargeWebViewScreen extends StatefulWidget {
  final String url;

  RechargeWebViewScreen(this.url);

  @override
  State<RechargeWebViewScreen> createState() => _RechargeWebViewScreenState();
}

class _RechargeWebViewScreenState extends State<RechargeWebViewScreen> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.disabled)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment WebView'),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}

