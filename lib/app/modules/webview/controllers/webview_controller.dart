import 'package:get/get.dart';
import 'package:praktikum/app/data/models/articles.dart';
import 'package:webview_flutter/webview_flutter.dart';

class IniWebViewController extends GetxController {
  RxList<Article> articles = RxList<Article>([]);
  RxBool isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
  }

  WebViewController webViewController(String uri) {
    return WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(uri));
  }
}
