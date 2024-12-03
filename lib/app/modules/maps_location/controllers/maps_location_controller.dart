import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MapsLocationController extends GetxController {
  Rx<Position?> currentPosition = Rx<Position?>(null);
  RxString locationMessage = "Mencari Lat dan Long...".obs;
  RxString address = "Mencari alamat...".obs; // Menyimpan alamat
  RxBool loading = false.obs;
  GoogleMapController? mapController; // Controller untuk GoogleMap
  Rx<LatLng?> currentLatLng = Rx<LatLng?>(null);
  Rx<LatLng?> lastGeocodedLatLng = Rx<LatLng?>(null);
  Timer? debounceTimer;

  // Mendapatkan lokasi terkini
  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    loading.value = true;

    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        throw Exception('Location service not enabled');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permission denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permission denied forever');
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      currentPosition.value = position;

      // Perbarui posisi marker merah ke posisi lokasi awal
      currentLatLng.value = LatLng(position.latitude, position.longitude);
      updateCurrentLatLng(currentLatLng.value!);

      locationMessage.value =
          "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
      loading.value = false;
    } catch (e) {
      loading.value = false;
      locationMessage.value = 'Gagal mendapatkan lokasi';
    }
  }

  // Perbarui nilai currentLatLng dari posisi kamera, bukan posisi perangkat
  void updateCurrentLatLng(LatLng target) {
    currentLatLng.value = target;

    // Debounce reverse geocoding
    debounceTimer?.cancel();
    debounceTimer = Timer(const Duration(milliseconds: 500), () {
      // Hanya lakukan reverse geocoding jika target baru berbeda dari yang terakhir
      if (lastGeocodedLatLng.value != target) {
        reverseGeocode(target);
      }
    });
  }

  Future<void> reverseGeocode(LatLng target) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(target.latitude, target.longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        address.value =
            "${place.street}, ${place.subLocality}, ${place.locality}, ${place.country}";
      } else {
        address.value = "Alamat tidak ditemukan";
      }

      // Simpan lokasi terakhir yang berhasil di-geocode
      lastGeocodedLatLng.value = target;
    } catch (e) {
      print("Error in reverse geocoding: $e");
      address.value = "Tempat tidak dikenal!";
    }
  }

  // Membuka Google Maps
  void openGoogleMaps() {
    if (lastGeocodedLatLng.value != null) {
      final url = Uri.parse(
          'https://www.google.com/maps?q=${lastGeocodedLatLng.value!.latitude},${lastGeocodedLatLng.value!.longitude}');
      _launchURL(url);
    }
  }

  // Meluncurkan URL
  void _launchURL(Uri url) async {
    if (await canLaunch(url.toString())) {
      await launch(url.toString());
    } else {
      throw 'Could not launch $url';
    }
  }
}
