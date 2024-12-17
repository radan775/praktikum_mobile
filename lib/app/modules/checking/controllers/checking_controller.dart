import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CheckingController extends GetxController {
  String? _selectedDate; // Ubah ke String untuk menyimpan dayName
  int _selectedTimeSlot = -1;

  String? get selectedDate => _selectedDate;
  int get selectedTimeSlot => _selectedTimeSlot;

  void selectDate(DateTime date) {
    _selectedDate =
        DateFormat('EEEE', 'id_ID').format(date); // Simpan nama hari
    update(); // Memperbarui tampilan
  }

  void selectTimeSlot(int index) {
    _selectedTimeSlot = index;
    update(); // Memperbarui tampilan
  }

  void confirmSelection() {
    if (_selectedDate != null && _selectedTimeSlot != -1) {
      DateTime selectedDateTime =
          DateTime.now().add(Duration(days: _getDayOffset(_selectedDate!)));

      Get.back(result: {
        'selectedDate': _selectedDate,
        'dateString': DateFormat('dd MMMM yyyy', 'id_ID')
            .format(selectedDateTime), // Format dengan nama bulan
        'timeSlotString': _getTimeSlotString(_selectedTimeSlot),
      });
    } else {
      Get.snackbar(
        'Peringatan',
        'Silakan pilih tanggal dan waktu terlebih dahulu',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent.shade700,
        colorText: Colors.white,
        icon: Icon(
          Icons.warning_rounded,
          color: Colors.white,
        ),
        margin: EdgeInsets.all(15),
        borderRadius: 10,
        duration: Duration(seconds: 3),
        boxShadows: [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          )
        ],
      );
    }
  }

  int _getDayOffset(String dayName) {
    final now = DateTime.now();
    for (int i = 0; i < 4; i++) {
      if (DateFormat('EEEE', 'id_ID').format(now.add(Duration(days: i))) ==
          dayName) {
        return i;
      }
    }
    return 0;
  }

  String _getTimeSlotString(int index) {
    switch (index) {
      case 0:
        return '08:00 - 10:00';
      case 1:
        return '10:00 - 12:00';
      case 2:
        return '12:00 - 14:00';
      case 3:
        return '14:00 - 16:00';
      case 4:
        return '16:00 - 18:00';
      default:
        return '';
    }
  }
}
