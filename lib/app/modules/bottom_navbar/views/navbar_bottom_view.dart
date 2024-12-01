import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:praktikum/app/modules/bottom_navbar/controllers/navbar_bottom_controller.dart';
import 'package:praktikum/app/modules/home/views/home_view.dart';
import 'package:praktikum/app/modules/http_screen_list/views/http_view.dart';

class NavbarView extends GetView<NavbarController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        // Tampilan berdasarkan tab yang dipilih
        return IndexedStack(
          index: controller.selectedIndex.value,
          children: [
            Navigator(
              key: Get.nestedKey(0), // Kunci untuk tab pertama
              onGenerateRoute: (settings) => GetPageRoute(
                page: () => HomeView(),
              ),
            ),
            Navigator(
              key: Get.nestedKey(1), // Kunci untuk tab kedua
              onGenerateRoute: (settings) => GetPageRoute(
                page: () => HttpView(),
              ),
            ),
            Navigator(
              key: Get.nestedKey(2), // Kunci untuk tab kedua
              onGenerateRoute: (settings) => GetPageRoute(
                page: () => Center(child: Text('Sensor View')),
              ),
            ),
            Navigator(
              key: Get.nestedKey(3), // Kunci untuk tab kedua
              onGenerateRoute: (settings) => GetPageRoute(
                page: () => Center(child: Text('Likes View')),
              ),
            ),
            Navigator(
              key: Get.nestedKey(4), // Kunci untuk tab kedua
              onGenerateRoute: (settings) => GetPageRoute(
                page: () => Center(child: Text('Acoount View')),
              ),
            ),
          ],
        );
      }),
      bottomNavigationBar: Container(
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
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.web,
                  text: 'Webview',
                ),
                GButton(
                  icon: Icons.sensors,
                  text: 'Sensor',
                ),
                GButton(
                  icon: LineIcons.heart,
                  text: 'Likes',
                ),
                GButton(
                  icon: Icons.account_box_rounded,
                  text: 'Account',
                )
              ],
              selectedIndex: controller.selectedIndex.value,
              onTabChange: (index) {
                controller.changeTab(index); // Ubah tab
              },
            ),
          ),
        ),
      ),
    );
  }
}
