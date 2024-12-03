import 'package:get/get.dart';
import 'package:praktikum/app/modules/bottom_navbar/bindings/navbar_bottom_binding.dart';
import 'package:praktikum/app/modules/bottom_navbar/views/navbar_bottom_view.dart';
import 'package:praktikum/app/modules/detail_product/bindings/detailproduct_binding.dart';
import 'package:praktikum/app/modules/detail_product/views/detailproduct_view.dart';
import 'package:praktikum/app/modules/forgot_password/bindings/forgot_binding.dart';
import 'package:praktikum/app/modules/forgot_password/views/forgot_view.dart';
import 'package:praktikum/app/modules/geolocation/bindings/geolocation_binding.dart';
import 'package:praktikum/app/modules/geolocation/views/geolocation_view.dart';
import 'package:praktikum/app/modules/http_screen_list/bindings/http_binding.dart';
import 'package:praktikum/app/modules/http_screen_list/views/http_view.dart';
import 'package:praktikum/app/modules/login/bindings/login_binding.dart';
import 'package:praktikum/app/modules/login/views/login_views.dart';
import 'package:praktikum/app/modules/maps_location/bindings/maps_location_binding.dart';
import 'package:praktikum/app/modules/maps_location/views/maps_location_view.dart';
import 'package:praktikum/app/modules/mikrofon/bindings/mikrofon_binding.dart';
import 'package:praktikum/app/modules/mikrofon/views/mikrofon_views.dart';
import 'package:praktikum/app/modules/register/bindings/register_binding.dart';
import 'package:praktikum/app/modules/register/views/register_view.dart';
import 'package:praktikum/app/modules/webview/bindings/webview_binding.dart';
import 'package:praktikum/app/modules/webview/views/webview_view.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(currentLatLng: Get.arguments),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.BOTTOM_NAVBAR,
      page: () => NavbarView(currentLatLng: Get.arguments),
      binding: NavbarBottomBinding(),
    ),
    GetPage(
      name: _Paths.HTTP,
      page: () => HttpView(),
      binding: HttpBinding(),
    ),
    GetPage(
      name: _Paths.INI_WEBVIEW,
      page: () => IniWebviewView(article: Get.arguments),
      binding: IniWebviewBinding(),
    ),
    GetPage(
      name: _Paths.GEOLOCATION,
      page: () => GeolocationView(),
      binding: GeolocationBinding(),
    ),
    GetPage(
      name: _Paths.MAPS_LOCATION,
      page: () => MapsLocationView(),
      binding: MapsLocationBinding(),
    ),
    GetPage(
      name: _Paths.MIKROFON,
      page: () => MikrofonView(),
      binding: MikrofonBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PRODUCT,
      page: () => DetailProductView(),
      binding: DetailProductBinding(),
    ),
  ];
}
