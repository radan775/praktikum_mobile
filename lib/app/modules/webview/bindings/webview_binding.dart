import 'package:get/get.dart';
import 'package:praktikum/app/modules/webview/controllers/webview_controller.dart';

class IniWebviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IniWebViewController>(
      () => IniWebViewController(),
    );
  }
}
