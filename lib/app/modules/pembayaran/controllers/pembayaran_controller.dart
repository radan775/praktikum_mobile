import 'dart:math';
import 'package:get/get.dart';

class PembayaranController extends GetxController {
  // List metode pembayaran sebagai observable
  final paymentMethods = <String>[
    'DANA',
    'Gopay',
    'Bank Jago',
    'Seabank',
    'BNI Virtual Account',
    'BRI Virtual Account',
    'BCA Virtual Account',
  ].obs;

  // Variabel observable untuk metode pembayaran yang dipilih
  final selectedPaymentMethod = ''.obs;

  // Observable untuk total belanja
  final totalBelanja = 'Rp 350.000'.obs;

  // Observable untuk nomor pesanan
  final orderNumber = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Generate nomor pesanan saat controller diinisialisasi
    orderNumber.value = 'K-${generateRandomOrderNumber()}';
  }

  // Fungsi untuk memilih metode pembayaran
  void selectPaymentMethod(String method) {
    selectedPaymentMethod.value = method;
  }

  String generateRandomOrderNumber() {
    final random1 = Random().nextInt(900000) + 100000;
    final random2 = Random().nextInt(900000) + 100000;
    return "$random1-$random2";
  }
}
