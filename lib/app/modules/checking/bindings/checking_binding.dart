import 'package:get/get.dart';
import 'package:praktikum/app/modules/checking/controllers/checking_controller.dart';

class CheckingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckingController>(
      () => CheckingController(),
    );
  }
}
