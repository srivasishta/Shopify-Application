import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final WebViewController _controller;
  bool _isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted) // Enable JS
      ..setNavigationDelegate(NavigationDelegate(
        onPageFinished: (url) {
          setState(() {
            _isLoading = false; // Hide loader when page loads
          });
        },
      ))
      ..loadRequest(Uri.parse("https://materialsoflove.com/"));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("WebView App")),
        body: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (_isLoading) // Show loader while loading
              Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}