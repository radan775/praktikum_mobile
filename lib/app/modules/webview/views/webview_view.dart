import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:praktikum/app/data/models/articles.dart';
import 'package:praktikum/app/modules/webview/controllers/webview_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class IniWebviewView extends GetView<IniWebViewController> {
  final Article article;

  const IniWebviewView({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ini WebView"),
      ),
      body: WebViewWidget(
        controller: controller.webViewController(article.url),
      ),
    );
  }
}
