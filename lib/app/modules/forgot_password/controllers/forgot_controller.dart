import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final verificationCodeController = TextEditingController();

  // Observables
  var isVerificationSent = false.obs;
  var remainingTime = 60.obs; // Waktu mundur untuk resend
  late Timer _timer;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    emailController.dispose();
    verificationCodeController.dispose();
    _timer.cancel();
    super.onClose();
  }

  void sendVerificationCode() {
    if (emailController.text.isNotEmpty) {
      isVerificationSent.value = true;
      startCountdown();
      Get.snackbar(
        'Kode Terkirim',
        'Kode verifikasi telah dikirim ke email Anda',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.snackbar(
        'Error',
        'Email tidak boleh kosong',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Fungsi untuk memulai countdown 60 detik
  void startCountdown() {
    remainingTime.value = 60; // reset countdown
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime.value > 0) {
        remainingTime.value--; // Mengurangi waktu setiap detik
      } else {
        _timer.cancel(); // stop timer when time is up
      }
    });
  }

  void resendVerificationCode() {
    if (remainingTime.value == 0) {
      sendVerificationCode(); // Resend code
    }
  }

  void resetPassword() {
    if (verificationCodeController.text.isNotEmpty) {
      Get.snackbar(
        'Berhasil',
        'Password Anda telah diatur ulang',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.snackbar(
        'Error',
        'Kode verifikasi tidak boleh kosong',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
