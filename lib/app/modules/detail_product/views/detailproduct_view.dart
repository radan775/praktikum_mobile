import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:praktikum/app/modules/detail_product/controllers/detailproduct_controller.dart';
import 'dart:ui' as ui;

import 'package:praktikum/app/routes/app_pages.dart';

class DetailProductView extends GetView<DetailproductController> {
  final Map<String, dynamic> product;

  DetailProductView({super.key, required this.product}) {
    controller.updateProduct(product);
    print("INI PRODUCT $product");
  }

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    final ValueNotifier<int> currentIndex = ValueNotifier<int>(0);
    final ValueNotifier<bool> isFavorite = ValueNotifier<bool>(false);

    String formatCurrency(int price) {
      return NumberFormat("#,###", "id_ID").format(price);
    }

    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageCarousel(pageController, currentIndex),
            const SizedBox(height: 8),
            _buildImageIndicator(currentIndex),
            const SizedBox(height: 8),
            _buildProductDetails(formatCurrency, isFavorite),
            const SizedBox(height: 5),
            const Divider(thickness: 8, color: Color(0xFFD7D3D3)),
            const SizedBox(height: 5),
            _buildStoreDetails(),
            const Divider(thickness: 8, color: Color(0xFFD7D3D3)),
            _buildProductDescription(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        'Detail Product',
        style: GoogleFonts.poppins(
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 4,
      actions: [
        IconButton(
          icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
          onPressed: () {
            Get.toNamed(Routes.CART);
          },
        ),
      ],
    );
  }

  Widget _buildImageCarousel(
      PageController pageController, ValueNotifier<int> currentIndex) {
    return SizedBox(
      height: 300,
      child: PageView.builder(
        controller: pageController,
        itemCount: 1,
        onPageChanged: (index) => currentIndex.value = index,
        itemBuilder: (context, index) {
          return Image.network(
            controller.product["imageUrl"],
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: 300,
          );
        },
      ),
    );
  }

  Widget _buildImageIndicator(ValueNotifier<int> currentIndex) {
    return ValueListenableBuilder<int>(
      valueListenable: currentIndex,
      builder: (context, value, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            1,
            (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: value == index ? 12 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: value == index ? Colors.teal : Colors.grey,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProductDetails(
      String Function(int) formatCurrency, ValueNotifier<bool> isFavorite) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '${controller.product["currency"]}${formatCurrency((controller.product["price"] as num).toInt())}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  controller.product["productName"],
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Text(
                  controller.product["categoryName"],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    'Terjual ${NumberFormat.decimalPattern("id_ID").format(controller.product["soldCount"])}',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Text("•",
                      style: TextStyle(fontSize: 16, color: Colors.grey)),
                  const SizedBox(width: 6),
                  const Icon(Icons.star, size: 18, color: Colors.orange),
                  const SizedBox(width: 4),
                  Text(
                    '${controller.product["rating"]}',
                    style: const TextStyle(fontSize: 15, color: Colors.black87),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildStoreDetails() {
    return Row(
      children: [
        ClipOval(
          child: Image.network(
            controller.product["storeLogo"],
            width: 80,
            height: 80,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 80,
                height: 80,
                color: Colors.grey[200],
              );
            },
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return Container(
                width: 80,
                height: 80,
                color: Colors.grey[200],
              );
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Posisi otomatis di tengah
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.store, size: 18, color: Colors.black),
                  const SizedBox(width: 5),
                  Flexible(
                    child: Text(
                      controller.product["storeName"],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis, // Batasi nama toko
                    ),
                  ),
                ],
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  // Hitung panjang teks untuk menentukan maxLines
                  final text = controller.product["storeAddress"];
                  final textPainter = TextPainter(
                    text: TextSpan(
                      text: text,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    maxLines: 1,
                    textDirection:
                        ui.TextDirection.ltr, // Pastikan ini didefinisikan
                  )..layout(maxWidth: constraints.maxWidth);

                  // Tentukan maxLines berdasarkan panjang teks
                  final isLongAddress = textPainter.didExceedMaxLines;

                  return Text(
                    text,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                    maxLines: isLongAddress ? 2 : 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign:
                        isLongAddress ? TextAlign.left : TextAlign.center,
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProductDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Deskripsi Produk',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          Text(
            controller.product["description"],
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: () => Get.toNamed(Routes.CHAT),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
              backgroundColor: const Color(0xFF56ab2f),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Icon(Icons.chat, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () => print("TAMBAH KERANJANG"),
              icon: const Icon(Icons.shopping_cart),
              label: const Text('+ keranjang'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 13),
                backgroundColor: const Color(0xFF56ab2f),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
