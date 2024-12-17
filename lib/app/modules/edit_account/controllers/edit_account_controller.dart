import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditAccountController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  void saveAccount() {
    // Logika untuk menyimpan data akun
    final name = nameController.text;
    final phone = phoneController.text;
    final email = emailController.text;

    // Lakukan validasi atau simpan ke server/database
    print("Nama: $name, No HP: $phone, Email: $email");

    Get.snackbar(
      "Berhasil",
      "Data akun berhasil diperbarui!",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void changePhoto() {
    // Logika untuk mengganti foto
    print("Ganti Foto Akun");
    Get.snackbar(
      "Info",
      "Fitur ganti foto belum tersedia.",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.orange,
      colorText: Colors.white,
    );
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.onClose();
  }
}
