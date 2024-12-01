import 'package:get/get.dart';

class LoginController extends GetxController {
  var phoneNumber = ''.obs;
  var password = ''.obs;

  // Observable untuk mengontrol visibilitas password
  var isPasswordHidden = true.obs;

  // Observable untuk menampilkan indikator loading
  var isLoading = false.obs;

  Future<void> login() async {
    if (phoneNumber.value.isEmpty || password.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Nomor HP dan password harus diisi',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isLoading.value = true;

      // Simulasi proses login (contoh penggunaan API)
      await Future.delayed(const Duration(seconds: 2));

      //Get.toNamed(Routes.HOME);
      print("berhasil login");
    } catch (e) {
      // Tampilkan pesan error
      Get.snackbar(
        'Login Gagal',
        'Periksa kembali nomor HP dan password Anda.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Fungsi untuk login menggunakan Google
  Future<void> loginWithGoogle() async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 2));

      // Jika login berhasil, navigasikan ke halaman HOME
      //Get.toNamed(Routes.HOME);
      print("berhasil login dengan google");
    } catch (e) {
      // Tampilkan pesan error
      Get.snackbar(
        'Login Gagal',
        'Login dengan Google tidak berhasil.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
