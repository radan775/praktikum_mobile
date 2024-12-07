import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:praktikum/app/data/widgets/product_card.dart';
import 'package:praktikum/app/modules/home/controllers/home_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:praktikum/app/modules/mikrofon/controllers/mikrofon_controller.dart';
import 'package:praktikum/app/routes/app_pages.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeView extends GetView<HomeController> {
  final CarouselSliderController carouselController =
      CarouselSliderController();
  final MikrofonController mikrofonController = Get.find<MikrofonController>();
  final Rx<LatLng?> currentLatLng;

  // Menambahkan RxString untuk menyimpan tombol yang dipilih
  final RxString selectedButton = 'none'.obs;

  HomeView({super.key, required this.currentLatLng}) {
    if (currentLatLng.value != null) {
      controller.updateLocation(currentLatLng.value!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            // Pencarian
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8), // Sudut rounded
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search,
                        color: Colors.black), // Ikon pencarian
                    const SizedBox(width: 8),
                    Expanded(
                      child: Obx(
                        () => TextField(
                          controller: TextEditingController(
                            text: mikrofonController.text.value,
                          )..selection = TextSelection.collapsed(
                              offset: mikrofonController.text.value.length,
                            ), // Fokuskan kursor di akhir teks
                          onChanged: (value) =>
                              mikrofonController.updateText(value),
                          decoration: InputDecoration(
                            hintText: "Cari hewan...",
                            hintStyle: const TextStyle(
                                fontSize: 16), // Ukuran font hint
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    Obx(() => IconButton(
                          icon: Icon(
                            mikrofonController.isListening.value
                                ? Icons.mic_off
                                : Icons.mic,
                            color: mikrofonController.isListening.value
                                ? Colors.red
                                : Colors.blue,
                          ),
                          onPressed: () {
                            if (mikrofonController.isListening.value) {
                              mikrofonController.stopListening();
                            } else {
                              mikrofonController.startListening();
                            }
                          },
                        )),
                  ],
                ),
              ),
            ),
            // Keranjang
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Get.toNamed(Routes.CART);
              },
            ),
            // Chat
            IconButton(
              icon: const Icon(Icons.chat),
              onPressed: () {
                print("Chat ditekan");
              },
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20),
          child: Obx(() => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 5,
                width: mikrofonController.isListening.value ? 100 : 0,
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  color: mikrofonController.isListening.value
                      ? Colors.green
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(5),
                ),
              )),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Carousel Image Slider
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0, // Tinggi carousel
                autoPlay: true, // Auto play
                autoPlayInterval: Duration(seconds: 3), // Interval tiap gambar
                enlargeCenterPage: true, // Perbesar gambar yang aktif
                viewportFraction: 0.8, // Fraksi tampilan gambar
              ),
              items: [
                // Gambar pertama
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://cdn0-production-images-kly.akamaized.net/zglhMgghWeRInbNk8nWENiq0XYo=/640x640/smart/filters:quality(75):strip_icc():format(webp)/kly-media-production/medias/3513930/original/066798000_1626578591-IMG-20210717-WA0006.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Gambar kedua
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://storage.nu.or.id/storage/post/16_9/mid/screenshot-2023-06-19-10-46-11-59-99c04817c0de5652397fc8b56c3b3817_1687146402.webp'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Gambar ketiga
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://donasi.yatimmandiri.org/_next/image?url=https%3A%2F%2Fdonasi.yatimmandiri.org%2Fstorage%2Fuploads%2F0qiGJQ57C3yOdHzcHX55Z7rAJs4uZHXm4ZtMEoAq.jpg&w=3840&q=75'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            // Titik indikator slider
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Obx(() {
                return AnimatedSmoothIndicator(
                  activeIndex: controller.currentIndex.value,
                  count: 3, // Jumlah item di carousel
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Color(0xFF56ab2f), // Warna hijau
                    dotHeight: 8.0,
                    dotWidth: 8.0,
                    spacing: 8.0,
                  ),
                );
              }),
            ),
            // Filter Categories
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 1.0, right: 2.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () async {
                              final selectedLatLng =
                                  await Get.toNamed(Routes.MAPS_LOCATION);
                              if (selectedLatLng != null &&
                                  selectedLatLng is LatLng) {
                                controller.updateLocation(selectedLatLng);
                                print("Lokasi terpilih: $selectedLatLng");
                              } else {
                                print("Tidak ada lokasi yang dipilih");
                              }
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.red, // Warna ikon lokasi
                                  size: 20,
                                ),
                                SizedBox(
                                    width: 4), // Jarak antara ikon dan teks
                                Text(
                                  "Lokasi: ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Obx(
                                () => Text(
                                  controller.address.value,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[
                                        800], // Warna abu-abu gelap untuk teks
                                    fontStyle: FontStyle
                                        .italic, // Menambahkan gaya italic
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.start, // Dimulai dari kiri
                    children: [
                      // Tombol Filter
                      Obx(() {
                        return TextButton(
                          onPressed: () {
                            selectedButton.value =
                                selectedButton.value == 'filter'
                                    ? 'none'
                                    : 'filter';
                            print("Filter clicked");
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: selectedButton.value == 'filter'
                                ? Colors.green.withOpacity(
                                    0.8) // Warna hijau transparan saat dipilih
                                : Colors.grey
                                    .withOpacity(0.1), // Warna latar default
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(12), // Sudut membulat
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12), // Spasi dalam tombol
                          ),
                          child: Row(
                            mainAxisSize:
                                MainAxisSize.min, // Ukuran sesuai konten
                            children: [
                              Icon(
                                Icons.filter_alt, // Ikon filter
                                color: selectedButton.value == 'filter'
                                    ? Colors.white
                                    : Colors.green,
                                size: 16, // Ukuran ikon lebih kecil
                              ),
                              SizedBox(width: 8), // Jarak antara ikon dan teks
                              Text(
                                "Filter",
                                style: TextStyle(
                                  color: selectedButton.value == 'filter'
                                      ? Colors.white
                                      : Colors.green,
                                  fontSize: 12, // Ukuran teks lebih kecil
                                  fontWeight: FontWeight.bold, // Teks tebal
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                      SizedBox(width: 10), // Jarak antar tombol
                      // Tombol Sapi
                      Obx(() {
                        return TextButton(
                          onPressed: () {
                            selectedButton.value =
                                selectedButton.value == 'sapi'
                                    ? 'none'
                                    : 'sapi';
                            print("Sapi clicked");
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: selectedButton.value == 'sapi'
                                ? Colors.orangeAccent.withOpacity(
                                    0.8) // Warna oranye saat dipilih
                                : Colors.grey.withOpacity(0.1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                          ),
                          child: Text(
                            "Sapi",
                            style: TextStyle(
                              color: selectedButton.value == 'sapi'
                                  ? Colors.white
                                  : Colors.orange,
                              fontSize: 12, // Ukuran teks lebih kecil
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }),
                      SizedBox(width: 10),
                      // Tombol Kambing
                      Obx(() {
                        return TextButton(
                          onPressed: () {
                            selectedButton.value =
                                selectedButton.value == 'kambing'
                                    ? 'none'
                                    : 'kambing';
                            print("Kambing clicked");
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: selectedButton.value == 'kambing'
                                ? Colors.purple
                                    .withOpacity(0.8) // Warna ungu saat dipilih
                                : Colors.grey.withOpacity(0.1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                          ),
                          child: Text(
                            "Kambing",
                            style: TextStyle(
                              color: selectedButton.value == 'kambing'
                                  ? Colors.white
                                  : Colors.purple,
                              fontSize: 12, // Ukuran teks lebih kecil
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }),
                      SizedBox(width: 10),
                      // Tombol Domba
                      Obx(() {
                        return TextButton(
                          onPressed: () {
                            selectedButton.value =
                                selectedButton.value == 'domba'
                                    ? 'none'
                                    : 'domba';
                            print("Domba clicked");
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: selectedButton.value == 'domba'
                                ? Colors.blueAccent
                                    .withOpacity(0.8) // Warna biru saat dipilih
                                : Colors.grey.withOpacity(0.1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                          ),
                          child: Text(
                            "Domba",
                            style: TextStyle(
                              color: selectedButton.value == 'domba'
                                  ? Colors.white
                                  : Colors.blue,
                              fontSize: 12, // Ukuran teks lebih kecil
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }),
                    ],
                  )
                ],
              ),
            ),
            // Konten utama aplikasi di sini
            GridView.builder(
              shrinkWrap: true,
              physics:
                  NeverScrollableScrollPhysics(), // Menonaktifkan scroll pada grid
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Menampilkan 2 kartu per baris
                crossAxisSpacing: 4.0, // Jarak antar kartu secara horizontal
                mainAxisSpacing: 8.0, // Jarak antar kartu secara vertikal
                mainAxisExtent: 345,
              ),
              itemCount: 9, // Jumlah total kartu
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(0.5), // Jarak antar kartu
                  child: ProductCard(
                    imageUrl:
                        'https://www.swiss-farmers.ch/app/uploads/2023/10/schweizer-baeuerinnen-und-bauern_rindvieh-1200x900.jpg',
                    categoryName: 'Sapi',
                    productName: 'Sapi Jantan Simenttal',
                    price: 21500000,
                    currency: 'Rp',
                    soldCount: 1000,
                    onTap: () {
                      Get.toNamed(Routes.DETAIL_PRODUCT);
                    },
                    onFavoritePressed: () {},
                    shortDescription: 'sapi siap kurban',
                    rating: 4.2,
                    discountPercentage: 35.0,
                    isAvailable: true,
                    cardColor: Colors.white,
                    textColor: Colors.black,
                    borderRadius: 8.0,
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
