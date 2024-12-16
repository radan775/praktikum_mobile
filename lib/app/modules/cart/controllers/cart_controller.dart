import 'package:get/get.dart';

class CartController extends GetxController {
  // Data toko dan produk
  final stores = [
    {
      "storeName": "Nama Toko A",
      "products": [
        {"productName": "Nama Produk 1", "price": "Rp 100.000"},
        {"productName": "Nama Produk 2", "price": "Rp 200.000"},
      ],
      "address": "Jl. Jalanan No. 12, Kecamatan Apapun, Kabupaten Disana",
    },
    {
      "storeName": "Nama Toko B",
      "products": [
        {"productName": "Nama Produk 3", "price": "Rp 300.000"},
      ],
      "address": "Jl. Kenanga Indah No. 12, Kecamatan Utara, Kabupaten Selatan",
    },
  ].obs;

  // State untuk checkbox toko dan produk
  final selectedStores = <String, bool>{}.obs;
  final selectedProducts = <String, bool>{}.obs;
  final productQuantities = <String, int>{}.obs;

  @override
  void onInit() {
    super.onInit();

    // Inisialisasi checkbox dan quantity
    for (var store in stores) {
      // Cast ke String secara eksplisit
      final storeName = store['storeName'] as String;
      selectedStores[storeName] = false;

      for (var product in store['products'] as List<Map<String, dynamic>>) {
        final productName = product['productName'] as String;
        selectedProducts[productName] = false;
        productQuantities[productName] = 1;
      }
    }
  }

  // Mengubah status checkbox toko
  void toggleStoreSelection(String storeName) {
    selectedStores[storeName] = !(selectedStores[storeName] ?? false);
    update();
  }

  // Mengubah status checkbox produk
  void toggleProductSelection(String productName) {
    selectedProducts[productName] = !(selectedProducts[productName] ?? false);
    update();
  }

  // Menambah jumlah produk
  void incrementQuantity(String productName) {
    if ((productQuantities[productName] ?? 1) < 99) {
      productQuantities[productName] =
          (productQuantities[productName] ?? 1) + 1;
      update();
    }
  }

  // Mengurangi jumlah produk
  void decrementQuantity(String productName) {
    if ((productQuantities[productName] ?? 1) > 1) {
      productQuantities[productName] =
          (productQuantities[productName] ?? 1) - 1;
      update();
    }
  }
}
