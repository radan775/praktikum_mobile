import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:praktikum/app/modules/settings/controllers/settings_controller.dart';
import 'package:praktikum/app/routes/app_pages.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100, // Warna latar belakang abu-abu
      appBar: AppBar(
        title: const Text(
          "Akun",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF56ab2f),
        elevation: 3,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Bagian Atas: Foto Akun dan Info Akun
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF56ab2f),
                  const Color(0xFF56ab2f).withOpacity(0.8),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(16),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Lingkaran Foto Akun
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 4,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.network(
                        "https://via.placeholder.com/150", // Gambar akun placeholder
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Informasi Akun
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Nama Akun",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "email@contoh.com",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "username_akun",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Icon Edit
                  IconButton(
                    onPressed: () {
                      Get.toNamed(Routes.EDIT_ACCOUNT);
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // List Items dengan efek interaktif
          Expanded(
            child: Column(
              children: [
                _buildListItem(
                    title: "Informasi akun", icon: Icons.account_circle),
                _buildDivider(),
                _buildListItem(title: "Privasi", icon: Icons.lock),
                _buildDivider(),
                _buildListItem(title: "Bantuan", icon: Icons.help_outline),
                _buildDivider(),
                _buildListItem(title: "Tentang", icon: Icons.info_outline),
              ],
            ),
          ),

          // Tombol Log Out
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  print("Log Out");
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  backgroundColor: const Color(0xFF56ab2f),
                  shadowColor: Colors.black26,
                ),
                child: const Text(
                  "Log Out",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget List Item dengan efek interaktif
  Widget _buildListItem({required String title, required IconData icon}) {
    return InkWell(
      onTap: () {
        print("Menu $title ditekan");
      },
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF56ab2f)),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  // Divider dengan padding
  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Divider(
        color: Colors.grey,
        thickness: 0.5,
      ),
    );
  }
}
