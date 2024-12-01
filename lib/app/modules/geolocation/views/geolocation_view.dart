import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:praktikum/app/modules/geolocation/controllers/geolocation_controller.dart';
import 'package:praktikum/app/routes/app_pages.dart';

class GeolocationView extends GetView<GeolocationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start, // Teks rata kiri
          children: [
            const Text(
              "Selamat datang di aplikasi kurban!\nSilahkan isi lokasi kamu!",
              textAlign: TextAlign.left, // Teks rata kiri
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Warna teks utama
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Untuk memberikan rekomendasi dan jangkauan yang sesuai dengan radius lokasi kamu berada, kami membutuhkan akses lokasi kamu.",
              textAlign: TextAlign.left, // Teks rata kiri
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey, // Warna teks sekunder
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Image.network(
                "https://cdn.pixabay.com/photo/2014/11/10/11/43/map-525349_960_720.png",
                height: 200,
                fit: BoxFit.cover, // Mengatur ukuran gambar agar proporsional
              ),
            ),
            const SizedBox(height: 20),
            // Tombol "Masukkan lokasi saya" dengan InkWell
            Center(
              child: Container(
                width: double.infinity, // Tombol memenuhi lebar layar
                decoration: BoxDecoration(
                  color: Colors.grey[300], // Warna latar belakang
                  borderRadius: BorderRadius.circular(8), // Sudut membulat
                ),
                child: InkWell(
                  onTap: () async {
                    // Navigasi ke MapsLocationView dan tunggu hasilnya
                    final selectedLatLng =
                        await Get.toNamed(Routes.MAPS_LOCATION);
                    if (selectedLatLng != null && selectedLatLng is LatLng) {
                      controller.updateLocation(selectedLatLng);
                      print("Lokasi terpilih: $selectedLatLng");
                    } else {
                      print("Tidak ada lokasi yang dipilih");
                    }
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Obx(() => Text(
                                  controller.address.value,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                )),
                          ),
                        ),
                        const Icon(
                          Icons.location_pin,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GestureDetector(
          onTap: () {
            // Logika tombol
            Get.toNamed(Routes.BOTTOM_NAVBAR);
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF56ab2f), Color(0xFFa8e063)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Center(
              child: Text(
                "Pakai lokasi ini",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Warna teks putih untuk kontras
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
