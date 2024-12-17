import 'package:get/get.dart';
import 'package:praktikum/app/modules/pembayaran/controllers/pembayaran_controller.dart';

class PembayaranBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PembayaranController>(
      () => PembayaranController(),
    );
  }
}
