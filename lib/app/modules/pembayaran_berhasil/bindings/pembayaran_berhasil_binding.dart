import 'package:get/get.dart';
import 'package:praktikum/app/modules/pembayaran_berhasil/controllers/pembayaran_berhasil_controller.dart';

class PembayaranBerhasilBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PembayaranBerhasilController>(
      () => PembayaranBerhasilController(),
    );
  }
}
