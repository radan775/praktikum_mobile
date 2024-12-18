import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//import '../views/no_connection_view.dart';

class ConnectionController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen((connectivityResults) {
      // Jika connectivityResults adalah List<ConnectivityResult>, kita ambil hasil pertama
      _updateConnectionStatus(connectivityResults.first);
    });
  }

  // Fungsi untuk mengupdate status koneksi
  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      // Tidak ada koneksi
      Get.snackbar(
        'Koneksi Terputus',
        'Tidak ada koneksi internet.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 5),
        margin: const EdgeInsets.all(10),
      );
    } else {
      // Koneksi tersedia (WiFi atau Mobile Data)
      Get.snackbar(
        'Koneksi Tersambung',
        'Internet berhasil terhubung.',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 5),
        margin: const EdgeInsets.all(10),
      );
    }
  }
}
