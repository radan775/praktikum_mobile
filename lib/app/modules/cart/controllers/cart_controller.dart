import 'package:get/get.dart';

class CartController extends GetxController {
  var cartItems = [
    {
      'productMeta': {
        'name': 'Product 1',
        'imageUrl': 'https://via.placeholder.com/60',
      },
      'quantity': 2,
      'price': 10.0,
      'discount': 2.0,
    },
    {
      'productMeta': {
        'name': 'Product 2',
        'imageUrl': 'https://via.placeholder.com/60',
      },
      'quantity': 1,
      'price': 20.0,
      'discount': 5.0,
    },
  ].obs;

  double get subtotal => cartItems.fold(
      0,
      (sum, item) =>
          sum + (item['price'] as double) * (item['quantity'] as int));

  double get discount => cartItems.fold(
      0,
      (sum, item) =>
          sum + (item['discount'] as double) * (item['quantity'] as int));

  double get total => subtotal - discount;
}
