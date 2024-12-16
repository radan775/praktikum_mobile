import 'package:get/get.dart';

class IniChatController extends GetxController {
  final messages = <String>[].obs;
  final messageController = ''.obs;

  void sendMessage() {
    if (messageController.isNotEmpty) {
      messages.add(messageController.value);
      messageController.value = '';
    }
  }
}
