import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class IniWebViewController extends GetxController {
  String url_webview = "";
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
