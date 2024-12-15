import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:praktikum/app/modules/cart/controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Keranjang',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          backgroundColor:
              const Color.fromARGB(255, 203, 199, 199), // Warna diubah
        ),
        body: Center(
          child: Text("KERANJANG"),
        ));
  }
}
