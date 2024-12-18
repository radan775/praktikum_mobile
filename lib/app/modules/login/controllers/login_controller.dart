import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:praktikum/app/routes/app_pages.dart';

class LoginController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var isPasswordHidden = true.obs;
  var isLoading = false.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> login() async {
    if (email.value.isEmpty || password.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Email dan password harus diisi',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    // Validasi format email
    if (!GetUtils.isEmail(email.value)) {
      Get.snackbar(
        'Error',
        'Format email tidak valid',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    try {
      isLoading.value = true;

      // Query untuk mencari user berdasarkan email
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email.value)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final userData =
            querySnapshot.docs.first.data() as Map<String, dynamic>;

        // Cek password
        if (userData['password'] == password.value) {
          Get.snackbar('Sukses', 'Login berhasil');

          // Simpan data pengguna jika perlu
          print("User data: $userData");

          // Navigasi ke halaman home
          Get.offAllNamed(Routes.GEOLOCATION, arguments: userData);
        } else {
          Get.snackbar('Error', 'Password salah');
        }
      } else {
        Get.snackbar('Error', 'Email tidak ditemukan');
      }
    } catch (e) {
      Get.snackbar('Login Gagal', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
