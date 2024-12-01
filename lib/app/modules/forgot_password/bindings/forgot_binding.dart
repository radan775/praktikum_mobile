import 'package:get/get.dart';
import 'package:praktikum/app/modules/forgot_password/controllers/forgot_controller.dart';

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordController>(
      () => ForgotPasswordController(),
    );
  }
}
