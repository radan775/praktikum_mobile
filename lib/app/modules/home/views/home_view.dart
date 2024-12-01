import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:praktikum/app/data/widgets/product_card.dart';
import 'package:praktikum/app/modules/home/controllers/home_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:praktikum/app/modules/mikrofon/controllers/mikrofon_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeView extends GetView<HomeController> {
  final CarouselSliderController carouselController =
      CarouselSliderController();
  final MikrofonController mikrofonController = Get.find<MikrofonController>();

  // Menambahkan RxString untuk menyimpan tombol yang dipilih
  RxString selectedButton = 'none'.obs;

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Pencarian
            Container(
              width: 300, // Lebar container pencarian
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
                        decoration: const InputDecoration(
                          hintText: 'Cari produk...',
                          hintStyle:
                              TextStyle(fontSize: 16), // Ukuran font hint
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
            // Keranjang
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                print("Keranjang ditekan");
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
              carouselController:
                  carouselController, // Menggunakan CarouselSliderController
              options: CarouselOptions(
                height: 200.0, // Menentukan tinggi carousel
                autoPlay: true, // Menyalakan auto play
                autoPlayInterval: Duration(seconds: 3), // Interval per gambar
                enlargeCenterPage: true, // Memperbesar gambar yang aktif
                onPageChanged: (index, reason) {
                  // Update variabel reaktif ketika page berubah
                  controller.currentIndex.value = index;
                },
              ),
              items: [
                // Item pertama (gambar atau teks)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.blue,
                  ),
                  child: Center(
                    child: Text(
                      "Promo 1: Diskon besar!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                // Item kedua (gambar atau teks)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.red,
                  ),
                  child: Center(
                    child: Text(
                      "Promo 2: Beli 1 Gratis 1!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                // Item ketiga (gambar atau teks)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.green,
                  ),
                  child: Center(
                    child: Text(
                      "Promo 3: Diskon 50%",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
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
              padding: const EdgeInsets.only(
                  left: 15, right: 15, bottom: 10), // Menambahkan padding kiri
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.start, // Memastikan dimulai dari kiri
                children: [
                  // Filter Button dengan gradien latar belakang saat dipilih
                  Obx(() {
                    return OutlinedButton(
                      onPressed: () {
                        // Jika tombol yang sama diklik, reset ke 'none'
                        if (selectedButton.value == 'filter') {
                          selectedButton.value = 'none';
                        } else {
                          selectedButton.value = 'filter'; // Menyimpan status
                        }
                        print("Filter clicked");
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: selectedButton.value == 'filter'
                              ? Colors.green // Warna hijau saat terpilih
                              : Colors
                                  .transparent, // Tidak ada border jika tidak terpilih
                        ),
                        backgroundColor: selectedButton.value == 'filter'
                            ? Color(0xFF56ab2f) // Warna hijau saat terpilih
                            : Colors
                                .transparent, // Tidak ada background jika tidak terpilih
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8), // Sudut rounded
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.filter_alt_outlined,
                              color: selectedButton.value == 'filter'
                                  ? Colors.white
                                  : Colors.green), // Ikon filter
                          SizedBox(width: 5), // Jarak antara ikon dan teks
                          Text(
                            "Filter",
                            style: TextStyle(
                              color: selectedButton.value == 'filter'
                                  ? Colors.white
                                  : Colors.green,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  // Sapi Button
                  Obx(() {
                    return TextButton(
                      onPressed: () {
                        // Jika tombol yang sama diklik, reset ke 'none'
                        if (selectedButton.value == 'sapi') {
                          selectedButton.value = 'none';
                        } else {
                          selectedButton.value = 'sapi'; // Menyimpan status
                        }
                        print("Sapi clicked");
                      },
                      style: TextButton.styleFrom(
                        side: BorderSide(
                          color: selectedButton.value == 'sapi'
                              ? Colors.green // Warna hijau saat terpilih
                              : Colors
                                  .transparent, // Tidak ada border jika tidak terpilih
                        ),
                        backgroundColor: selectedButton.value == 'sapi'
                            ? Color(0xFF56ab2f) // Warna hijau saat terpilih
                            : Colors
                                .transparent, // Tidak ada background jika tidak terpilih
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8), // Sudut rounded
                        ),
                      ),
                      child: Text(
                        "Sapi",
                        style: TextStyle(
                          color: selectedButton.value == 'sapi'
                              ? Colors.white
                              : Colors.green,
                        ),
                      ),
                    );
                  }),
                  // Kambing Button
                  Obx(() {
                    return TextButton(
                      onPressed: () {
                        // Jika tombol yang sama diklik, reset ke 'none'
                        if (selectedButton.value == 'kambing') {
                          selectedButton.value = 'none';
                        } else {
                          selectedButton.value = 'kambing'; // Menyimpan status
                        }
                        print("Kambing clicked");
                      },
                      style: TextButton.styleFrom(
                        side: BorderSide(
                          color: selectedButton.value == 'kambing'
                              ? Colors.green // Warna hijau saat terpilih
                              : Colors
                                  .transparent, // Tidak ada border jika tidak terpilih
                        ),
                        backgroundColor: selectedButton.value == 'kambing'
                            ? Color(0xFF56ab2f) // Warna hijau saat terpilih
                            : Colors
                                .transparent, // Tidak ada background jika tidak terpilih
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8), // Sudut rounded
                        ),
                      ),
                      child: Text(
                        "Kambing",
                        style: TextStyle(
                          color: selectedButton.value == 'kambing'
                              ? Colors.white
                              : Colors.green,
                        ),
                      ),
                    );
                  }),
                  // Domba Button
                  Obx(() {
                    return TextButton(
                      onPressed: () {
                        // Jika tombol yang sama diklik, reset ke 'none'
                        if (selectedButton.value == 'domba') {
                          selectedButton.value = 'none';
                        } else {
                          selectedButton.value = 'domba'; // Menyimpan status
                        }
                        print("Domba clicked");
                      },
                      style: TextButton.styleFrom(
                        side: BorderSide(
                          color: selectedButton.value == 'domba'
                              ? Colors.green // Warna hijau saat terpilih
                              : Colors
                                  .transparent, // Tidak ada border jika tidak terpilih
                        ),
                        backgroundColor: selectedButton.value == 'domba'
                            ? Color(0xFF56ab2f) // Warna hijau saat terpilih
                            : Colors
                                .transparent, // Tidak ada background jika tidak terpilih
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8), // Sudut rounded
                        ),
                      ),
                      child: Text(
                        "Domba",
                        style: TextStyle(
                          color: selectedButton.value == 'domba'
                              ? Colors.white
                              : Colors.green,
                        ),
                      ),
                    );
                  }),
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
                crossAxisSpacing: 5.0, // Jarak antar kartu secara horizontal
                mainAxisSpacing: 8.0, // Jarak antar kartu secara vertikal
                mainAxisExtent: 391,
              ),
              itemCount: 9, // Jumlah total kartu
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(8.0), // Jarak antar kartu
                  child: ProductCard(
                    imageUrl:
                        'https://www.swiss-farmers.ch/app/uploads/2023/10/schweizer-baeuerinnen-und-bauern_rindvieh-1200x900.jpg',
                    categoryName: 'Sapi',
                    productName: 'Men Linen Pants',
                    price: 199.99,
                    currency: '\$', // Default is '$'
                    onTap: () {},
                    onFavoritePressed: () {},
                    shortDescription: 'comfortable & airy.',
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
