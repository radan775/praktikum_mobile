import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:praktikum/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  // Text Editing Controllers untuk input form
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Method untuk validasi dan proses pendaftaran
  void register() {
    final name = nameController.text.trim();
    final phone = phoneController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (name.isEmpty ||
        phone.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      Get.snackbar(
        "Error",
        "Semua kolom harus diisi!",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar(
        "Error",
        "Password dan konfirmasi password tidak cocok!",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (phone.length < 10) {
      Get.snackbar(
        "Error",
        "Nomor HP minimal 10 digit!",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Jika validasi berhasil
    Get.snackbar(
      "Pendaftaran Berhasil",
      "Anda telah berhasil mendaftar.",
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

    // Simpan data atau lanjut ke halaman berikutnya
    // Contoh: Navigasi ke halaman login
    Get.offAllNamed(Routes.LOGIN);
  }

  @override
  void onClose() {
    // Dispose semua controller
    nameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
