import 'package:get/get.dart';
import 'package:praktikum/app/modules/bottom_navbar/controllers/navbar_bottom_controller.dart';
import 'package:praktikum/app/modules/home/controllers/home_controller.dart';
import 'package:praktikum/app/modules/http_screen_list/controllers/http_controller.dart';
import 'package:praktikum/app/modules/mikrofon/controllers/mikrofon_controller.dart';

class NavbarBottomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavbarController>(() => NavbarController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<HttpController>(() => HttpController());
    Get.lazyPut<MikrofonController>(() => MikrofonController());
  }
}
