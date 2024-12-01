import 'package:get/get.dart';

class NavbarController extends GetxController {
  var selectedIndex = 0.obs; // Observable index for selected tab

  void changeTab(int index) {
    selectedIndex.value = index; // Update the selected tab
  }
}
