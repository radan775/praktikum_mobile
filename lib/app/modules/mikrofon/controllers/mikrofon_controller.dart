import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class MikrofonController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _initSpeech(); // Inisialisasi layanan pengenalan suara saat controller dibuat
  }

  // Instansiasi SpeechToText untuk menangani pengenalan suara
  final stt.SpeechToText _speech = stt.SpeechToText();

  // Variabel observable untuk melacak status aplikasi
  var isListening =
      false.obs; // Menunjukkan apakah aplikasi sedang mendengarkan suara
  var text = "".obs; // Menyimpan teks yang dihasilkan dari pengenalan suara

  // Menginisialisasi fungsi pengenalan suara
  void _initSpeech() async {
    try {
      await _speech.initialize();
    } catch (e) {
      print(e);
    }
  }

  // Memeriksa dan meminta izin mikrofon
  Future<void> checkMicrophonePermission() async {
    var status = await Permission.microphone.status;
    if (!status.isGranted) {
      // Jika izin belum diberikan, minta izin kepada pengguna
      await Permission.microphone.request();
    }
  }

  // Memulai mendengarkan suara dan memperbarui variabel teks dengan kata-kata yang dikenali
  void startListening() async {
    await checkMicrophonePermission();
    if (await Permission.microphone.isGranted) {
      isListening.value = true;
      await _speech.listen(onResult: (result) {
        // Memperbarui kata-kata yang dikenali ke dalam variabel teks
        text.value = result.recognizedWords;
      });
    } else {
      Get.snackbar(
        "Peringatan", // Judul snackbar
        "Izin mikrofon ditolak.", // Pesan yang ditampilkan
        snackPosition: SnackPosition.BOTTOM, // Posisi snackbar (BOTTOM/TOP)
        backgroundColor: Colors.red, // Warna latar belakang snackbar
        colorText: Colors.white, // Warna teks snackbar
        margin: EdgeInsets.all(10), // Margin dari snackbar
        duration: Duration(seconds: 3), // Durasi tampilan snackbar
      );
    }
  }

  // Menghentikan proses pengenalan suara
  void stopListening() async {
    isListening.value = false;
    await _speech.stop();
  }

  void updateText(String value) {
    text.value = value; // Update teks saat pengguna mengetik
  }
}
