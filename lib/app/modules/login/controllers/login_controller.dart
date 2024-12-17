import 'package:get/get.dart';

class LoginController extends GetxController {
  var email = ''.obs; // Ganti phoneNumber dengan email
  var password = ''.obs;
  var isPasswordHidden = true.obs;
  var isLoading = false.obs;

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
      // Simulasi proses login (contoh penggunaan API)
      await Future.delayed(const Duration(seconds: 2));
      print("berhasil login");
      // Get.toNamed(Routes.HOME); // Uncomment untuk navigasi ke HOME
    } catch (e) {
      Get.snackbar(
        'Login Gagal',
        'Periksa kembali email dan password Anda.',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loginWithGoogle() async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 2));
      print("berhasil login dengan google");
      // Get.toNamed(Routes.HOME); // Uncomment untuk navigasi ke HOME
    } catch (e) {
      Get.snackbar(
        'Login Gagal',
        'Login dengan Google tidak berhasil.',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
