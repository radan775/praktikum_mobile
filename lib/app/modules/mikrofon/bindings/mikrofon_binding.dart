import 'package:get/get.dart';
import 'package:praktikum/app/modules/mikrofon/controllers/mikrofon_controller.dart';

class MikrofonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MikrofonController>(() => MikrofonController());
  }
}
