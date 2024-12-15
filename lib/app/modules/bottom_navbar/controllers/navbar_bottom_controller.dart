import 'package:get/get.dart';

class NavbarController extends GetxController {
  // Index tab yang aktif
  RxInt selectedIndex = 0.obs;
  // Fungsi untuk mengubah tab
  void changeTab(int index) {
    selectedIndex.value = index;
  }
}
