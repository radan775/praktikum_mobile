import 'package:get/get.dart';

class HistoryController extends GetxController {
  // Data toko dan produk
  final stores = [
    {
      "storeName": "Nama Toko A",
      "products": [
        {"productName": "Nama Produk 1", "price": "Rp 100.000"},
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
}
