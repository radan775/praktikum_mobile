import 'package:get/get.dart';

class HomeController extends GetxController {
  var currentIndex = 0.obs;
  var text = ''.obs;

  void updateText(String value) {
    text.value = value; // Update teks saat pengguna mengetik
  }
}
