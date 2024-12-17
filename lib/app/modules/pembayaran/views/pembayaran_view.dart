import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:praktikum/app/modules/pembayaran/controllers/pembayaran_controller.dart';
import 'package:praktikum/app/routes/app_pages.dart';

class PembayaranView extends GetView<PembayaranController> {
  const PembayaranView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Pembayaran',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
        backgroundColor: const Color(0xFF56ab2f),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF56ab2f).withOpacity(0.1),
                    const Color(0xFF56ab2f).withOpacity(0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "No. pesanan:",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    controller.orderNumber.value,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF56ab2f),
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            );
          }),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Text(
              "Pilih Metode Pembayaran",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),

          // LIST METODE PEMBAYARAN
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: controller.paymentMethods.length,
              itemBuilder: (context, index) {
                final method = controller.paymentMethods[index];

                return Obx(() {
                  final isSelected =
                      controller.selectedPaymentMethod.value == method;
                  return InkWell(
                    onTap: () {
                      controller.selectPaymentMethod(method);
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF56ab2f).withOpacity(0.1)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF56ab2f)
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Icon(
                              isSelected
                                  ? Icons.check_circle
                                  : Icons.circle_outlined,
                              color: isSelected
                                  ? const Color(0xFF56ab2f)
                                  : Colors.grey.shade400,
                              size: 24,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Text(
                                method,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: isSelected
                                      ? const Color(0xFF56ab2f)
                                      : Colors.black87,
                                ),
                              ),
                            ),
                          ),
                          Icon(
                            Icons.payment_outlined,
                            color: const Color(0xFF56ab2f)
                                .withOpacity(isSelected ? 1.0 : 0.7),
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ),
                  );
                });
              },
            ),
          ),
        ],
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: Obx(() {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Total Belanja
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total Belanja",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    controller.totalBelanja.value,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF56ab2f),
                      letterSpacing: 1.1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: Icon(
                    controller.selectedPaymentMethod.value.isEmpty
                        ? Icons.payment_outlined
                        : Icons.payment,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "Proses Pembayaran",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF56ab2f),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation:
                        controller.selectedPaymentMethod.value.isEmpty ? 2 : 5,
                  ),
                  onPressed: () async {
                    if (controller.selectedPaymentMethod.value.isEmpty) {
                      // Jika metode pembayaran belum dipilih
                      Get.snackbar(
                        "Peringatan",
                        "Pilih metode pembayaran terlebih dahulu!",
                        backgroundColor: Colors.red.shade700,
                        colorText: Colors.white,
                      );
                    } else {
                      // Jika metode pembayaran sudah dipilih, tampilkan loading
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFF56ab2f),
                            ),
                          );
                        },
                      );

                      // Tunggu 2 detik (simulasi proses pembayaran)
                      await Future.delayed(const Duration(seconds: 2));

                      // Tutup dialog loading
                      Navigator.of(context).pop();

                      // Pindah ke halaman PembayaranBerhasil
                      Get.toNamed(Routes.PAYMENT_SUCCESS);
                    }
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
