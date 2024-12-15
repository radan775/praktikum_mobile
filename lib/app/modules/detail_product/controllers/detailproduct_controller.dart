import 'package:get/get.dart';

class DetailproductController extends GetxController {
  late Map<String, dynamic> product = <String, dynamic>{};

  void updateProduct(Map<String, dynamic> product) {
    this.product = product;
  }
}
