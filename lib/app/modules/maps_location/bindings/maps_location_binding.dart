import 'package:get/get.dart';
import 'package:praktikum/app/modules/maps_location/controllers/maps_location_controller.dart';

class MapsLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapsLocationController>(
      () => MapsLocationController(),
    );
  }
}
