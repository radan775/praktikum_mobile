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
  // Mengubah selectedSchedules menjadi map dengan kunci nama toko
  final selectedSchedules = <String, Map<String, String?>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    // Inisialisasi checkbox dan quantity
    for (var store in stores) {
      final storeName = store['storeName'] as String;
      selectedStores[storeName] = false;
      selectedSchedules[storeName] = {
        'selectedDate': null,
        'dateString': null,
        'timeSlotString': null,
      };
      for (var product in store['products'] as List<Map<String, dynamic>>) {
        final productName = product['productName'] as String;
        selectedProducts[productName] = false;
        productQuantities[productName] = 1;
      }
    }
  }

  void toggleStoreSelection(String storeName) {
    final isSelected = !(selectedStores[storeName] ?? false);
    selectedStores[storeName] = isSelected;

    // Ambil semua produk dari toko yang dipilih
    final store = stores.firstWhere((store) => store['storeName'] == storeName);
    for (var product in store['products'] as List<Map<String, dynamic>>) {
      final productName = product['productName'] as String;
      selectedProducts[productName] = isSelected;
    }
    update();
  }

  void toggleProductSelection(String productName) {
    final isSelected = !(selectedProducts[productName] ?? false);
    selectedProducts[productName] = isSelected;

    // Periksa apakah semua produk dalam satu toko dicentang
    for (var store in stores) {
      final storeName = store['storeName'] as String;
      final products = store['products'] as List<Map<String, dynamic>>;
      final allSelected = products.every(
          (product) => selectedProducts[product['productName']] ?? false);

      // Update status toko berdasarkan status produk
      if (allSelected) {
        selectedStores[storeName] = true;
      } else if (products.any(
          (product) => selectedProducts[product['productName']] == false)) {
        selectedStores[storeName] = false;
      }
    }
    update();
  }

  // Toggle semua checkbox (bottom navbar action)
  void toggleAllSelection(bool isSelected) {
    for (var store in stores) {
      final storeName = store['storeName'] as String;
      selectedStores[storeName] = isSelected;

      for (var product in store['products'] as List<Map<String, dynamic>>) {
        final productName = product['productName'] as String;
        selectedProducts[productName] = isSelected;
      }
    }
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

  void updateSchedule({
    required String storeName,
    String? selectedDate,
    String? dateString,
    String? timeSlotString,
  }) {
    if (selectedSchedules[storeName] != null) {
      if (selectedDate != null) {
        selectedSchedules[storeName]!['selectedDate'] = selectedDate;
      }
      if (dateString != null) {
        selectedSchedules[storeName]!['dateString'] = dateString;
      }
      if (timeSlotString != null) {
        selectedSchedules[storeName]!['timeSlotString'] = timeSlotString;
      }
    }
    update(); // Memperbarui tampilan
  }
}
