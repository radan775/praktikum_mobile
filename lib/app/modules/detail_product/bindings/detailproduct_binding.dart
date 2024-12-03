import 'package:get/get.dart';
import 'package:praktikum/app/modules/detail_product/controllers/detailproduct_controller.dart';

class DetailProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailproductController>(
      () => DetailproductController(),
    );
  }
}
