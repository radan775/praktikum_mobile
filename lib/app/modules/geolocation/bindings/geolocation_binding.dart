import 'package:get/get.dart';
import 'package:praktikum/app/modules/geolocation/controllers/geolocation_controller.dart';

class GeolocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GeolocationController>(
      () => GeolocationController(),
    );
  }
}
