import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeolocationController extends GetxController {
  Rx<LatLng?> currentLatLng = Rx<LatLng?>(null);
  RxString address = "Masukkan Lokasi Saya".obs; // Default tulisan tombol

  void updateLocation(LatLng latLng) {
    currentLatLng.value = latLng;
    print('GEO LOCATION: $latLng');
    if (currentLatLng.value != null) {
      reverseGeocode(currentLatLng.value!);
    }
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
      print("BERHASIL reverse GEOCODE");
    } catch (e) {
      print("Error in reverse geocoding: $e");
      address.value = "Tempat tidak dikenal!";
    }
  }
}
