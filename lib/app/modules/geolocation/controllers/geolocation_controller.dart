import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get_storage/get_storage.dart';

class GeolocationController extends GetxController {
  Rx<LatLng?> currentLatLng = Rx<LatLng?>(null);
  RxString address = "Masukkan Lokasi Saya".obs;
  var userData = <String, dynamic>{}.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Connectivity _connectivity = Connectivity();
  final GetStorage _storage = GetStorage();

  RxBool isConnected = true.obs;

  @override
  void onInit() {
    super.onInit();
    userData.value = Get.arguments ?? {};
    print("User Data di Controller: ${userData.value}");
    _listenToConnectionChanges();
    _checkAndSendStoredData(); // Cek data lokal saat inisialisasi
  }

  @override
  void onReady() {
    super.onReady();
    _checkConnectionManually(); // Cek koneksi manual ketika halaman dimuat
  }

  // Cek status koneksi secara manual
  Future<void> _checkConnectionManually() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      isConnected.value = false;
      address.value = "Koneksi internet mati";
      print("Koneksi internet mati (manual check).");
    } else {
      isConnected.value = true;
      print("Koneksi internet tersedia (manual check).");
      _checkAndSendStoredData(); // Kirim data lokal jika ada
    }
  }

  // Pantau status koneksi internet
  void _listenToConnectionChanges() {
    _connectivity.onConnectivityChanged.listen((connectivityResult) async {
      if (connectivityResult == ConnectivityResult.none) {
        isConnected.value = false;
        address.value = "Koneksi internet mati";
        print("Koneksi internet mati");
      } else {
        isConnected.value = true;
        print("Koneksi internet tersedia");
        await _checkAndSendStoredData(); // Kirim data lokal jika ada
      }
    });
  }

  // Perbarui lokasi pengguna
  void updateLocation(LatLng latLng) async {
    currentLatLng.value = latLng;
    print('GEO LOCATION: $latLng');
    print("TES ${isConnected.value}");

    if (!isConnected.value) {
      // Simpan lokasi ke lokal jika tidak ada koneksi
      _storeLocationLocally(latLng);
      address.value = "Koneksi internet mati";
      print("Data lokasi disimpan secara lokal: $latLng");
      return;
    }

    if (currentLatLng.value != null) {
      _storeLocationLocally(latLng);
      address.value = "Koneksi internet mati";
      print("Data lokasi disimpan secara lokal: $latLng");
      await reverseGeocode(currentLatLng.value!);
      if (address.value != "Tempat tidak dikenal!") {
        await updateLocationToFirestore(latLng); // Kirim ke Firestore
      } else {
        print("Reverse Geocode gagal, data tidak dikirim ke Firestore.");
      }
    }
  }

  // Reverse geocoding untuk mendapatkan alamat dari koordinat
  Future<void> reverseGeocode(LatLng target) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(target.latitude, target.longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        address.value =
            "${place.street}, ${place.subLocality}, ${place.locality}, ${place.country}";
        print("Reverse Geocode berhasil: ${address.value}");
      } else {
        address.value = "Alamat tidak ditemukan";
      }
    } catch (e) {
      print("Error in reverse geocoding: $e");
      address.value = "Tempat tidak dikenal!";
    }
  }

  // Kirim lokasi ke Firestore
  Future<void> updateLocationToFirestore(LatLng latLng) async {
    try {
      if (!isConnected.value) {
        print("Koneksi mati, data tidak dikirim ke Firestore.");
        return;
      }

      String email = userData['email'];

      await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get()
          .then((querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          String docId = querySnapshot.docs.first.id;
          _firestore.collection('users').doc(docId).update({
            'currentLatLng': {
              'latitude': latLng.latitude,
              'longitude': latLng.longitude,
            },
          });
          print("Lokasi berhasil diupdate ke Firestore: $latLng");
          Get.snackbar("Sukses", "Lokasi berhasil diperbarui di Firestore");
        } else {
          print("User tidak ditemukan");
          Get.snackbar("Error", "User tidak ditemukan di Firestore");
        }
      });
    } catch (e) {
      print("Error update lokasi ke Firestore: $e");
      Get.snackbar("Error", "Gagal memperbarui lokasi di Firestore");
    }
  }

  // Simpan lokasi ke lokal jika tidak ada koneksi
  void _storeLocationLocally(LatLng latLng) {
    _storage.write('pendingLatLng', {
      'latitude': latLng.latitude,
      'longitude': latLng.longitude,
    });
    print("Data lokasi disimpan secara lokal: $latLng");
  }

  // Kirim data lokal ke Firestore saat koneksi tersedia
  Future<void> _checkAndSendStoredData() async {
    if (_storage.hasData('pendingLatLng')) {
      // Ambil data yang disimpan
      Map<String, dynamic> pendingLatLng = _storage.read('pendingLatLng');
      LatLng latLng = LatLng(
        pendingLatLng['latitude'],
        pendingLatLng['longitude'],
      );

      // Kirim data ke Firestore jika koneksi tersedia
      if (isConnected.value) {
        print("Mengirim data lokal ke Firestore: $latLng");

        // Pastikan reverse geocode berhasil sebelum mengirim data
        await reverseGeocode(latLng);
        if (address.value != "Tempat tidak dikenal!") {
          await updateLocationToFirestore(latLng);
          // Hapus data dari storage jika berhasil dikirim
          _storage.remove('pendingLatLng');
          print(
              "Data lokal berhasil dikirim dan dihapus dari penyimpanan lokal.");
        } else {
          print(
              "Reverse Geocode gagal, data lokal tidak dikirim ke Firestore.");
        }
      }
    }
  }
}
