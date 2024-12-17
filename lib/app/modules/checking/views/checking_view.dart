import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:praktikum/app/modules/checking/controllers/checking_controller.dart';
import 'package:intl/intl.dart';

class CheckingView extends GetView<CheckingController> {
  const CheckingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pilih waktu pengambilan',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF56ab2f),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Pilih tanggal:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 12),
              GetBuilder<CheckingController>(
                builder: (controller) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildDateButton(DateTime.now(), controller), // Hari ini
                      _buildDivider(), // Divider
                      _buildDateButton(DateTime.now().add(Duration(days: 1)),
                          controller), // Besok
                      _buildDivider(), // Divider
                      _buildDateButton(DateTime.now().add(Duration(days: 2)),
                          controller), // Lusa
                      _buildDivider(), // Divider
                      _buildDateButton(DateTime.now().add(Duration(days: 3)),
                          controller), // 3 hari kemudian
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              const Text(
                "Pilih jam:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 12),
              GetBuilder<CheckingController>(
                builder: (controller) {
                  return Column(
                    children: [
                      _buildTimeSlotItem("08:00 - 10:00", 0, controller),
                      _buildTimeSlotItem("10:00 - 12:00", 1, controller),
                      _buildTimeSlotItem("12:00 - 14:00", 2, controller),
                      _buildTimeSlotItem("14:00 - 16:00", 3, controller),
                      _buildTimeSlotItem("16:00 - 18:00", 4, controller),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(controller),
    );
  }

  Widget _buildDateButton(DateTime date, CheckingController controller) {
    // Dapatkan nama hari dari tanggal
    String dayName = DateFormat('EEEE', 'id_ID').format(date);
    return Column(
      children: [
        GestureDetector(
          onTap: () => controller.selectDate(date),
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: controller.selectedDate == dayName
                  ? const Color(0xFF56ab2f).withOpacity(0.1)
                  : Colors.transparent,
            ),
            child: Center(
              child: Text(
                DateFormat('dd').format(date),
                style: TextStyle(
                  fontSize: 36,
                  color: controller.selectedDate == dayName
                      ? const Color(0xFF56ab2f)
                      : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          dayName,
          style: TextStyle(
            fontSize: 12,
            color: controller.selectedDate == dayName
                ? const Color(0xFF56ab2f)
                : Colors.black54,
            fontWeight: controller.selectedDate == dayName
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),
        if (controller.selectedDate == dayName)
          Container(
            width: 30,
            height: 3,
            color: const Color(0xFF56ab2f),
            margin: const EdgeInsets.only(top: 4),
          ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 50,
      width: 2,
      color: Colors.grey.shade300,
    );
  }

  Widget _buildTimeSlotItem(
      String timeSlot, int index, CheckingController controller) {
    return ListTile(
      title: Text(
        timeSlot,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Radio<int>(
        value: index,
        groupValue: controller.selectedTimeSlot,
        onChanged: (value) {
          controller.selectTimeSlot(value!);
        },
        activeColor: const Color(0xFF56ab2f),
      ),
    );
  }

  Widget _buildBottomNavBar(CheckingController controller) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            controller.confirmSelection();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF56ab2f),
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            "OK",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
