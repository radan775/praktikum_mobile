import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:praktikum/app/modules/maps_location/controllers/maps_location_controller.dart';

class MapsLocationView extends GetView<MapsLocationController> {
  const MapsLocationView({super.key});

  @override
  Widget build(BuildContext context) {
    // Memastikan izin lokasi diminta saat pertama kali widget ditampilkan
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.getCurrentLocation();
      if (controller.currentLatLng.value != null) {
        controller.mapController?.animateCamera(
          CameraUpdate.newLatLng(controller.currentLatLng.value!),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pilih lokasi anda"),
        automaticallyImplyLeading: false,
      ),
      body: Obx(() {
        return Stack(
          children: [
            // Google Maps as Background
            GoogleMap(
              onMapCreated: (GoogleMapController mapCtrl) {
                controller.mapController = mapCtrl;
                controller.updateCurrentLatLng(controller.currentLatLng.value ??
                    const LatLng(6.1944, 106.8229));
              },
              initialCameraPosition: CameraPosition(
                target: controller.currentLatLng.value ??
                    const LatLng(6.1944, 106.8229),
                zoom: 15.0,
              ),
              zoomControlsEnabled: false,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              onCameraMove: (CameraPosition position) {
                controller.updateCurrentLatLng(position.target);
              },
            ),

            // Red marker at the center of the screen
            const Align(
              alignment: Alignment(0, -0.05),
              child: Icon(
                Icons.location_on,
                size: 50,
                color: Colors.red,
              ),
            ),

            // Tombol zoom dan lokasi
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Tombol zoom in
                    ZoomButton(
                      icon: Icons.add,
                      onPressed: () {
                        controller.mapController?.animateCamera(
                          CameraUpdate.zoomIn(),
                        );
                      },
                    ),
                    const SizedBox(height: 4),
                    // Tombol zoom out
                    ZoomButton(
                      icon: Icons.remove,
                      onPressed: () {
                        controller.mapController?.animateCamera(
                          CameraUpdate.zoomOut(),
                        );
                      },
                    ),
                    const SizedBox(height: 4),
                    // Tombol lokasi saya
                    ZoomButton(
                      icon: Icons.my_location,
                      onPressed: () async {
                        await controller.getCurrentLocation();
                        if (controller.currentLatLng.value != null) {
                          controller.mapController?.animateCamera(
                            CameraUpdate.newLatLng(
                                controller.currentLatLng.value!),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Bottom container
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.7),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8.0,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Titik Koordinat',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Obx(() {
                      final latLng = controller.currentLatLng.value;
                      if (latLng != null) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Latitude: ${latLng.latitude}",
                              style: const TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                            ),
                            Text(
                              "Longitude: ${latLng.longitude}",
                              style: const TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                            ),
                          ],
                        );
                      } else {
                        return const Text(
                          "Mencari Lat dan Long...",
                          style: TextStyle(fontSize: 16.0, color: Colors.white),
                        );
                      }
                    }),
                    const SizedBox(height: 8.0),
                    Obx(() {
                      return Text(
                        controller.address.value,
                        style: const TextStyle(
                            fontSize: 16.0, color: Colors.white),
                      );
                    }),
                    const SizedBox(height: 16.0),
                    ElevatedButton.icon(
                      onPressed: () {
                        final selectedLatLng = controller.currentLatLng.value;
                        if (selectedLatLng != null) {
                          print('Lokasi dipilih: $selectedLatLng');
                          // return value ke halaman sebelumnya
                          Get.back(result: selectedLatLng);
                        } else {
                          print('Lokasi belum dipilih');
                        }
                      },
                      icon: const Icon(Icons.check_circle),
                      label: const Text('Pilih lokasi ini'),
                    ),
                    const SizedBox(height: 8.0),
                    ElevatedButton.icon(
                      onPressed: () {
                        controller.openGoogleMaps();
                      },
                      icon: const Icon(Icons.map),
                      label: const Text('Buka Google Maps'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class ZoomButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const ZoomButton({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, size: 20),
        onPressed: onPressed,
        padding: EdgeInsets.zero,
      ),
    );
  }
}
