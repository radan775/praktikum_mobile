import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  // Variable untuk menyimpan tema (true = dark, false = light)
  var isDarkMode = false.obs;

  // Fungsi untuk toggle tema
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }
}
