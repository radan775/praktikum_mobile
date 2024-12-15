import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeController extends GetxController {
  Rx<LatLng?> currentLatLng = Rx<LatLng?>(null);
  RxString address = "Alamat belum dipilih".obs;
  var currentIndex = 0.obs;
  var text = ''.obs;
  var selectedButton = ''.obs;

  // Carousel Data
  final List<Map<String, String>> carouselData = [
    {
      "title": "Artikel 1: Sapi Kurban Berkualitas",
      "image":
          "https://cdn0-production-images-kly.akamaized.net/zglhMgghWeRInbNk8nWENiq0XYo=/640x640/smart/filters:quality(75):strip_icc():format(webp)/kly-media-production/medias/3513930/original/066798000_1626578591-IMG-20210717-WA0006.jpg",
      "link_webview": "https://palangkaraya.go.id/siapkan-hewan-kurban/",
    },
    {
      "title": "Artikel 2: Cara Memilih Hewan Kurban",
      "image":
          "https://storage.nu.or.id/storage/post/16_9/mid/screenshot-2023-06-19-10-46-11-59-99c04817c0de5652397fc8b56c3b3817_1687146402.webp",
      "link_webview":
          "https://diskominfo.kaltimprov.go.id/kesehatan/syarat-dan-ketentuan-hewan-kurban-masyarakat-wajib-tahu",
    },
    {
      "title": "Artikel 3: Pentingnya Sedekah Kurban",
      "image":
          "https://donasi.yatimmandiri.org/_next/image?url=https%3A%2F%2Fdonasi.yatimmandiri.org%2Fstorage%2Fuploads%2F0qiGJQ57C3yOdHzcHX55Z7rAJs4uZHXm4ZtMEoAq.jpg&w=3840&q=75",
      "link_webview":
          "https://baznas.go.id/artikel-show/Waktu-Penyembelihan-Kurban-Adalah-Tanggal-Berapa/472",
    },
  ];

  final List<Map<String, dynamic>> productData = [
    {
      "categoryName": "Unta",
      "productName": "Unta Jantan",
      "imageUrl":
          "https://img.lovepik.com/png/20231112/camal-clipart-cartoon-camel-illustration-with-desert-background-vector-landscape_566483_wh860.png",
      "price": 35000000.0,
      "currency": "Rp",
      "soldCount": 15,
      "rating": 4.5,
      "description":
          "Unta Jantan dewasa, sangat cocok untuk digunakan dalam berbagai kegiatan tradisional seperti lomba atau acara perayaan. Dikenal karena kekuatannya dan daya tahannya yang tinggi di iklim panas.",
      "storeName": "Toko Unta Nusantara",
      "storeLogo":
          "https://i.pinimg.com/474x/12/9d/33/129d33dc8729928caf0567f020861314.jpg",
      "storeAddress": "Jalan Raya Pasar Hewan No. 12, Surabaya, Jawa Timur"
    },
    {
      "categoryName": "Unta",
      "productName": "Unta Betina",
      "imageUrl":
          "https://i.pinimg.com/736x/eb/fd/e5/ebfde57b2dd5786f93469155958adeea.jpg",
      "price": 30000000.0,
      "currency": "Rp",
      "soldCount": 20,
      "rating": 4.7,
      "description":
          "Unta Betina berkualitas tinggi dengan produksi susu yang baik. Ideal untuk peternakan unta atau untuk dikembangbiakkan. Memiliki sifat yang jinak dan mudah dirawat.",
      "storeName": "Camel Farm ID",
      "storeLogo":
          "https://img.pikbest.com/element_our/20220620/bg/86216875a443c.png",
      "storeAddress": "Desa Unta Makmur, Kecamatan Tambak, NTT"
    },
    {
      "categoryName": "Unta",
      "productName": "Unta Muda",
      "imageUrl":
          "https://st4.depositphotos.com/1967477/24061/v/1600/depositphotos_240613028-stock-illustration-vector-illustration-cartoon-funny-camel.jpg",
      "price": 25000000.0,
      "currency": "Rp",
      "soldCount": 10,
      "rating": 4.3,
      "description":
          "Unta muda yang energik dan mudah dilatih. Sangat cocok untuk mereka yang ingin memulai usaha peternakan atau memiliki pengalaman baru dalam merawat hewan eksotis.",
      "storeName": "Arabian Camel Breeder",
      "storeLogo":
          "https://i.pinimg.com/474x/1c/1e/0a/1c1e0ad6296abb8961efe50540149fd1.jpg",
      "storeAddress":
          "Jalan Peternakan Unta No. 45, Banjarmasin, Kalimantan Selatan"
    },
    {
      "categoryName": "Sapi",
      "productName": "Sapi Jantan Simental",
      "imageUrl":
          "https://i.pinimg.com/736x/8e/76/36/8e7636615bfbeee68c345054cb6161ad.jpg",
      "price": 22000000.0,
      "currency": "Rp",
      "soldCount": 100,
      "rating": 4.8,
      "description":
          "Sapi Jantan Simental terkenal karena bobotnya yang besar dan kualitas daging yang unggul. Ideal untuk dijadikan sapi kurban atau untuk peternakan besar.",
      "storeName": "Peternakan Sapi Maju",
      "storeLogo":
          "https://qurbanasyik.terasdakwah.com/wp-content/uploads/2024/05/SHORT-COURSE-LOGO-WEB-768x960.png",
      "storeAddress": "Jalan Raya Peternakan No. 88, Bogor, Jawa Barat"
    },
    {
      "categoryName": "Sapi",
      "productName": "Sapi Bali",
      "imageUrl":
          "https://i.pinimg.com/originals/df/e2/04/dfe20481c32199880bd18a602f24096a.png",
      "price": 20000000.0,
      "currency": "Rp",
      "soldCount": 80,
      "rating": 4.6,
      "description":
          "Sapi Bali merupakan sapi asli Indonesia yang terkenal dengan daya tahan tubuhnya. Sangat cocok untuk peternakan kecil dan cocok untuk berbagai iklim.",
      "storeName": "Bali Livestock",
      "storeLogo":
          "https://w7.pngwing.com/pngs/377/188/png-transparent-goat-qurbani-dairy-cattle-baka-islam-goat-animals-cow-goat-family-grass-thumbnail.png",
      "storeAddress": "Jalan Sawah Hijau No. 5, Denpasar, Bali"
    },
    {
      "categoryName": "Sapi",
      "productName": "Sapi Perah",
      "imageUrl":
          "https://st.depositphotos.com/1967477/2736/v/450/depositphotos_27367959-stock-illustration-cute-cow-cartoon.jpg",
      "price": 18000000.0,
      "currency": "Rp",
      "soldCount": 90,
      "rating": 4.7,
      "description":
          "Sapi Perah dengan hasil susu berkualitas tinggi. Pilihan terbaik untuk peternak yang ingin fokus pada produksi susu untuk kebutuhan pasar lokal maupun industri.",
      "storeName": "Dairy Farm ID",
      "storeLogo":
          "https://www.shutterstock.com/image-vector/qurban-idul-adha-muslim-man-260nw-1771171013.jpg",
      "storeAddress": "Jalan Industri Susu No. 7, Bandung, Jawa Barat"
    },
    {
      "categoryName": "Kambing",
      "productName": "Kambing Etawa",
      "imageUrl":
          "https://st4.depositphotos.com/2664341/28482/v/1600/depositphotos_284824446-stock-illustration-illustration-cute-cartoon-goat.jpg",
      "price": 3000000.0,
      "currency": "Rp",
      "soldCount": 150,
      "rating": 4.9,
      "description":
          "Kambing Etawa adalah kambing perah premium yang menghasilkan susu dengan kandungan gizi tinggi. Cocok untuk peternak yang fokus pada kualitas produk susu.",
      "storeName": "Etawa Indonesia",
      "storeLogo":
          "https://template.canva.com/EAGFHhrsA0o/1/0/800w-lrUCu7lzHXo.jpg",
      "storeAddress": "Desa Kambing Perah No. 2, Magelang, Jawa Tengah"
    },
    {
      "categoryName": "Kambing",
      "productName": "Kambing Kacang",
      "imageUrl":
          "https://st.depositphotos.com/2664341/3844/v/450/depositphotos_38448681-stock-illustration-goat-cartoon.jpg",
      "price": 2500000.0,
      "currency": "Rp",
      "soldCount": 200,
      "rating": 4.8,
      "description":
          "Kambing Kacang adalah kambing lokal Indonesia yang mudah dirawat dan sangat produktif. Pilihan tepat untuk usaha peternakan skala kecil maupun menengah.",
      "storeName": "Kambing Lokal Jaya",
      "storeLogo":
          "https://assets.promediateknologi.id/crop/0x0:0x0/750x500/webp/photo/2022/07/06/3096645555.png",
      "storeAddress": "Jalan Pedesaan No. 10, Malang, Jawa Timur"
    },
    {
      "categoryName": "Domba",
      "productName": "Domba Super",
      "imageUrl":
          "https://e7.pngegg.com/pngimages/546/912/png-clipart-timmy-sheep-character-illustration-aardman-animations-television-show-film-morph-sheep-television-animals.png",
      "price": 1800000.0,
      "currency": "Rp",
      "soldCount": 150,
      "rating": 4.9,
      "description":
          "Domba Super adalah jenis domba unggulan yang dirancang khusus untuk memenuhi kebutuhan peternakan modern. Dengan postur tubuh yang besar, pertumbuhan cepat, dan kualitas daging premium, domba ini menjadi pilihan utama untuk kebutuhan pasar daging yang berkualitas tinggi. ",
      "storeName": "Domba lokal",
      "storeLogo":
          "https://images.tokopedia.net/img/cache/700/VqbcmM/2024/1/18/704b6309-b684-44d3-ace6-28b67ab61ba3.png",
      "storeAddress": "Jalan Pedesaan No. 10, Malang, Jawa Timur"
    },
  ];

  @override
  void onInit() {
    super.onInit();
    filteredProductData.value = productData;

    // Dengarkan perubahan text (input teks atau mikrofon)
    text.listen((value) {
      filterProducts();
    });
  }

  RxList<Map<String, dynamic>> filteredProductData =
      <Map<String, dynamic>>[].obs;
  // Filter Options
  final List<String> filterOptions = [
    "Unta",
    "Sapi",
    "Kambing",
    "Domba",
  ];

  void updateText(String value) {
    text.value = value; // Update search text
  }

  void updateLocation(LatLng latLng) {
    currentLatLng.value = latLng;
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
    } catch (e) {
      address.value = "Tempat tidak dikenal!";
    }
  }

  void updateCarouselIndex(int index) {
    currentIndex.value = index; // Update carousel index
  }

  void updateSelectedFilter(String filter) {
    selectedButton.value = selectedButton.value == filter ? '' : filter;
    filterProducts(); // Panggil filter setiap kali kategori berubah
  }

  void filterProducts() {
    String searchText = text.value.toLowerCase();

    filteredProductData.value = productData.where((product) {
      final matchesCategory = selectedButton.value.isEmpty ||
          product["categoryName"] == selectedButton.value;

      final matchesSearch = searchText.isEmpty ||
          product["productName"].toString().toLowerCase().contains(searchText);

      return matchesCategory && matchesSearch;
    }).toList();
  }
}
