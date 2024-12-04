import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:praktikum/app/routes/app_pages.dart';

class ResetPasswordController extends GetxController {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Observables untuk kontrol visibilitas password
  var isPasswordHidden = true.obs;
  var isConfirmPasswordHidden = true.obs;

  // Metode untuk toggle visibilitas password
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
  }

  // Metode untuk submit reset password
  void submitResetPassword() {
    final newPassword = newPasswordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      Get.snackbar(
        'Error',
        'Password dan Konfirmasi Password tidak boleh kosong',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (newPassword != confirmPassword) {
      Get.snackbar(
        'Error',
        'Password dan Konfirmasi Password tidak cocok',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Proses reset password (contoh: API Call)
    Get.snackbar(
      'Sukses',
      'Password berhasil direset!',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

    // Bersihkan input field
    newPasswordController.clear();
    confirmPasswordController.clear();
    Get.offAllNamed(Routes.LOGIN);
  }
}
