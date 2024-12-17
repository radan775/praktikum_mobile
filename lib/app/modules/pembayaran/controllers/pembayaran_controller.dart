import 'dart:math';
import 'package:get/get.dart';

class PembayaranController extends GetxController {
  // List metode pembayaran
  final paymentMethods = <String>[
    'DANA',
    'Gopay',
    'Bank Jago',
    'Seabank',
    'BNI Virtual Account',
    'BRI Virtual Account',
    'BCA Virtual Account',
  ].obs;

  // Variabel untuk menyimpan metode pembayaran yang dipilih
  final selectedPaymentMethod = ''.obs;

  // Fungsi untuk memilih metode pembayaran
  void selectPaymentMethod(String method) {
    if (selectedPaymentMethod.value == method) {
      selectedPaymentMethod.value = '';
    } else {
      selectedPaymentMethod.value = method; // Pilih metode
    }
    update();
  }

  void refreshPaymentMethods() {
    update(); // Memuat ulang Obx dan widget terkait
  }

  String generateRandomOrderNumber() {
    final random1 = Random().nextInt(900000) + 100000;
    final random2 = Random().nextInt(900000) + 100000;
    return "$random1-$random2";
  }
}
