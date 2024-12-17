import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:praktikum/app/modules/history/controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: const Icon(Icons.search, color: Colors.black),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: "Cari hewan...",
                          hintStyle: TextStyle(fontSize: 16),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<HistoryController>(
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
                      index,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoreCard(
    HistoryController controller,
    String storeName,
    List<Map<String, String>> products,
    String address,
    int storeIndex,
  ) {
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
                      const Color(0xFF56ab2f),
                      const Color(0xFF56ab2f).withOpacity(0.8),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: const BorderRadius.vertical(
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
                          SizedBox(height: 8),
                          _buildProductRow(controller, product["productName"]!,
                              product["price"]!),
                          SizedBox(height: 8),
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
                padding:
                    const EdgeInsets.only(left: 8, right: 8, bottom: 6, top: 2),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: const BorderRadius.vertical(
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

  Widget _buildStoreHeader(HistoryController controller, String storeName) {
    return Row(
      children: [
        const Icon(Icons.store, color: Colors.white, size: 25),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              storeName,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              "17 desember 2024",
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 3)
          ],
        ),
        Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.white, // Warna background
            borderRadius: BorderRadius.circular(8), // Membuat background bundar
            border: Border.all(color: Colors.green, width: 1),
          ),
          child: Text(
            "selesai",
            style: TextStyle(
              fontSize: 14,
              color: Colors.green,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildProductRow(
      HistoryController controller, String productName, String price) {
    return Row(
      children: [
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
              Text(
                "(1 barang)",
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
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
      ],
    );
  }

  Widget _buildAddressSection(String address) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Sudah diambil di:",
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
}
