import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:praktikum/app/modules/cart/controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Keranjang',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF56ab2f), // Ganti warna AppBar
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<CartController>(
              builder: (controller) {
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 10,
                  ),
                  itemCount: controller.stores.length,
                  itemBuilder: (context, index) {
                    final store = controller.stores[index];
                    return _buildStoreCard(
                      controller,
                      store['storeName'] as String,
                      store['products'] as List<Map<String, String>>,
                      store['address'] as String,
                    );
                  },
                );
              },
            ),
          ),
          _buildBottomNavBar(),
        ],
      ),
    );
  }

  Widget _buildStoreCard(CartController controller, String storeName,
      List<Map<String, String>> products, String address) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.grey.shade50,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Store Header
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF56ab2f), // Warna pertama
                      Color(0xFF56ab2f).withOpacity(
                          0.8), // Warna kedua dengan sedikit opacity
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                ),
                child: _buildStoreHeader(controller, storeName),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    ...products.map(
                      (product) => Column(
                        children: [
                          _buildProductRow(controller, product["productName"]!,
                              product["price"]!),
                          if (product != products.last)
                            Divider(
                              color: Colors.grey.shade300,
                              thickness: 0.5,
                              height: 2,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Address Section
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(12),
                  ),
                ),
                child: _buildAddressSection(address),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStoreHeader(CartController controller, String storeName) {
    return Row(
      children: [
        Obx(() {
          return GestureDetector(
            onTap: () => controller.toggleStoreSelection(storeName),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: controller.selectedStores[storeName] ?? false
                    ? Colors.white
                    : Colors.transparent,
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: controller.selectedStores[storeName] ?? false
                  ? Icon(Icons.check,
                      color: Color(0xFF56ab2f),
                      size: 20) // Ganti warna check icon
                  : null,
            ),
          );
        }),
        SizedBox(width: 12),
        Icon(Icons.store, color: Colors.white, size: 22),
        SizedBox(width: 10),
        Text(
          storeName,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildProductRow(
      CartController controller, String productName, String price) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => controller.toggleProductSelection(productName),
          child: Obx(() {
            return Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black54),
                color: controller.selectedProducts[productName] ?? false
                    ? Colors.green
                    : Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
              child: controller.selectedProducts[productName] ?? false
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            );
          }),
        ),
        const SizedBox(width: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.network(
            "https://via.placeholder.com/150",
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 60,
                height: 60,
                color: Colors.grey[300],
                child: const Icon(Icons.image_not_supported, size: 30),
              );
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                productName,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                price,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
              ),
            ],
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () => controller.incrementQuantity(productName),
              icon: const Icon(Icons.add, size: 16),
              splashRadius: 15,
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              tooltip: 'Tambah',
            ),
            Obx(() {
              return Text(
                "${controller.productQuantities[productName] ?? 1}",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              );
            }),
            IconButton(
              onPressed: () => controller.decrementQuantity(productName),
              icon: const Icon(Icons.remove, size: 16),
              splashRadius: 15,
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              tooltip: 'Kurangi',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAddressSection(String address) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Ambil di:",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Text(
          address,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.normal,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavBar() {
    bool isBoxSelected = false;
    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isBoxSelected = !isBoxSelected;
                  });
                },
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isBoxSelected ? Color(0xFF56ab2f) : Colors.grey,
                      width: 2,
                    ),
                    color: isBoxSelected ? Color(0xFF56ab2f) : Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: isBoxSelected
                      ? const Icon(Icons.check, color: Colors.white, size: 16)
                      : null,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "Pilih Semua",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Total Harga",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Rp 300.000",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF56ab2f),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  print("Bayar ditekan");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF56ab2f),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 3,
                ),
                child: Text(
                  "Bayar",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
