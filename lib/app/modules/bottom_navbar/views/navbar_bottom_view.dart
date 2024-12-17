import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:praktikum/app/modules/history/views/history_view.dart';
import 'package:praktikum/app/modules/settings/views/settings_view.dart';
import 'package:praktikum/app/modules/bottom_navbar/controllers/navbar_bottom_controller.dart';
import 'package:praktikum/app/modules/home/views/home_view.dart';

class NavbarView extends GetView<NavbarController> {
  final Rx<LatLng?> currentLatLng;

  const NavbarView({super.key, required this.currentLatLng});

  @override
  Widget build(BuildContext context) {
    var pages = [
      HomeView(currentLatLng: currentLatLng),
      HistoryView(),
      SettingsView(),
    ];
    return Scaffold(
      body: Obx(() {
        // Menggunakan IndexedStack untuk menjaga status halaman
        return IndexedStack(
          index: controller.selectedIndex.value,
          children: List.generate(
            pages.length,
            (index) => Navigator(
              key: Get.nestedKey(index),
              onGenerateRoute: (settings) => GetPageRoute(
                page: () => pages[index],
              ),
            ),
          ),
        );
      }),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withOpacity(.1),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            rippleColor: Colors.grey[300]!,
            hoverColor: Colors.grey[100]!,
            gap: 5,
            activeColor: Colors.black,
            iconSize: 20,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            duration: const Duration(milliseconds: 400),
            tabBackgroundColor: Colors.grey[100]!,
            color: Colors.black,
            tabs: [
              const GButton(icon: LineIcons.home, text: 'Home'),
              const GButton(icon: LineIcons.history, text: 'History'),
              const GButton(icon: Icons.settings, text: 'Settings'),
            ],
            selectedIndex: controller.selectedIndex.value,
            onTabChange: (index) => controller.changeTab(index),
          ),
        ),
      ),
    );
  }
}
