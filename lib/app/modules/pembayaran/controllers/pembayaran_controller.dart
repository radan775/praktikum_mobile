import 'dart:math';
import 'package:get/get.dart';

class PembayaranController extends GetxController {
  // List metode pembayaran (reactive)
  final paymentMethods = <String>[
    'DANA',
    'Gopay',
    'Bank Jago',
    'Seabank',
    'BNI Virtual Account',
    'BRI Virtual Account',
    'BCA Virtual Account',
  ].obs;

  // Variabel menyimpan metode pembayaran terpilih
  final selectedPaymentMethod = ''.obs;

  // Variabel untuk nomor pesanan dan total belanja
  final orderNumber = ''.obs;
  final totalBelanja = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Generate nomor pesanan dan total belanja satu kali
    orderNumber.value = _generateRandomOrderNumber();
    totalBelanja.value = "Rp 350.000";
  }

  // Fungsi memilih / batal pilih metode pembayaran
  void selectPaymentMethod(String method) {
    if (selectedPaymentMethod.value == method) {
      // Jika sama dengan yang terpilih, unselect
      selectedPaymentMethod.value = '';
    } else {
      // Jika beda, pilih yang baru
      selectedPaymentMethod.value = method;
    }
  }

  String _generateRandomOrderNumber() {
    final random1 = Random().nextInt(900000) + 100000;
    final random2 = Random().nextInt(900000) + 100000;
    return "$random1-$random2";
  }
}
