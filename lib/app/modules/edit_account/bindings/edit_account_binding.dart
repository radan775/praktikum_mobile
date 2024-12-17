import 'package:get/get.dart';
import 'package:praktikum/app/modules/edit_account/controllers/edit_account_controller.dart';

class EditAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditAccountController>(
      () => EditAccountController(),
    );
  }
}
