import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:praktikum/app/modules/forgot_password/controllers/forgot_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Obx(() => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Lupa Password',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Masukkan email Anda untuk menerima kode verifikasi. Gunakan kode tersebut untuk mengatur ulang password.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    const SizedBox(height: 30),
                    // Input Email
                    TextField(
                      controller: controller.emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    // Tombol Kirim Kode
                    if (!controller.isVerificationSent.value)
                      GestureDetector(
                        onTap: controller.sendVerificationCode,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF56ab2f), Color(0xFFa8e063)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              'Kirim Kode',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      )
                    else ...[
                      const SizedBox(height: 16),
                      // Input Kode Verifikasi
                      TextField(
                        controller: controller.verificationCodeController,
                        decoration: InputDecoration(
                          labelText: 'Kode Verifikasi',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Tombol Atur Ulang Password
                      GestureDetector(
                        onTap: controller.resetPassword,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF56ab2f), Color(0xFFa8e063)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              'Atur Ulang Password',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Tombol Resend
                      if (controller.remainingTime.value == 0)
                        GestureDetector(
                          onTap: controller.resendVerificationCode,
                          child: const Center(
                            child: Text(
                              'Kirim Ulang Kode',
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        )
                      else
                        Center(
                          child: Text(
                            'Tunggu ${controller.remainingTime.value} detik untuk kirim ulang kode.',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                            ),
                          ),
                        ),
                    ],
                    const SizedBox(height: 30),
                    // Tautan Kembali
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Get.back(); // Kembali ke halaman sebelumnya
                        },
                        child: RichText(
                          text: const TextSpan(
                            text: 'Kembali ke ',
                            style: TextStyle(color: Colors.black87),
                            children: [
                              TextSpan(
                                text: 'Login',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
