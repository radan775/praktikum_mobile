import 'package:get/get.dart';
import 'package:praktikum/app/modules/http_screen_list/controllers/http_controller.dart';

class HttpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HttpController>(
      () => HttpController(),
    );
  }
}
