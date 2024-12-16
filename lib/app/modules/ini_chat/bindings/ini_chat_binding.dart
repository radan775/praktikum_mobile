import 'package:get/get.dart';
import 'package:praktikum/app/modules/ini_chat/controllers/ini_chat_controller.dart';

class IniChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IniChatController>(
      () => IniChatController(),
    );
  }
}
