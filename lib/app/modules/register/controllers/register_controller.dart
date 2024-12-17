import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:praktikum/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  // Text Editing Controllers untuk input form
  final nameController = TextEditingController();
  final emailController =
      TextEditingController(); // Ganti phoneController dengan emailController
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Method untuk validasi dan proses pendaftaran
  void register() {
    final name = nameController.text.trim();
    final email =
        emailController.text.trim(); // Ambil email dari emailController
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (name.isEmpty ||
        email.isEmpty ||
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

    // Validasi email
    if (!GetUtils.isEmail(email)) {
      Get.snackbar(
        "Error",
        "Format email tidak valid!",
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
    Get.offAllNamed(Routes.LOGIN);
  }

  @override
  void onClose() {
    // Dispose semua controller
    nameController.dispose();
    emailController.dispose(); // Dispose emailController
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
