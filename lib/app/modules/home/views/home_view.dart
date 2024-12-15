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
  final MikrofonController mikrofonController = Get.find<MikrofonController>();
  final Rx<LatLng?> currentLatLng;
  final double widhtFilter = 80;
  final double heightFilter = 30;
  final RxString selectedButton = 'none'.obs;

  HomeView({super.key, required this.currentLatLng}) {
    if (currentLatLng.value != null) {
      controller.updateLocation(currentLatLng.value!);
    }

    mikrofonController.text.listen((value) {
      controller.updateText(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildCarousel(),
            _buildSmoothIndicator(),
            _buildLocationRow(),
            _buildFilterButtons(),
            _buildProductGrid(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      controller.filterProducts();
                    },
                    child: const Icon(Icons.search, color: Colors.black),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Obx(
                      () => TextField(
                        controller: TextEditingController(
                          text: mikrofonController.text.value,
                        )..selection = TextSelection.collapsed(
                            offset: mikrofonController.text.value.length,
                          ),
                        onChanged: (value) {
                          mikrofonController.updateText(value);
                          controller.updateText(value); // Update teks pencarian
                        },
                        decoration: const InputDecoration(
                          hintText: "Cari hewan...",
                          hintStyle: TextStyle(fontSize: 16),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => IconButton(
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
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Get.toNamed(Routes.CART),
          ),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(20),
        child: Obx(
          () => AnimatedContainer(
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
          ),
        ),
      ),
    );
  }

  Widget _buildCarousel() {
    return CarouselSlider(
      items: controller.carouselData
          .map(
            (entry) => GestureDetector(
              onTap: () {
                Get.toNamed(Routes.INI_WEBVIEW,
                    arguments: entry["link_webview"]);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Container(
                            color: Colors.grey[300], // Blank area sementara
                            child: const Center(
                              child:
                                  CircularProgressIndicator(), // Animasi loading
                            ),
                          ),
                          Image.network(
                            entry["image"]!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 200,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child; // Gambar selesai dimuat
                              }
                              return Container(
                                color:
                                    Colors.grey[300], // Latar belakang abu-abu
                                child: const Center(
                                  child:
                                      CircularProgressIndicator(), // Animasi loading
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              // Penanganan jika gambar gagal dimuat
                              return Container(
                                color: Colors.grey[300],
                                child: const Center(
                                  child: Icon(
                                    Icons.image_not_supported,
                                    color: Colors.grey,
                                    size: 50,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Flexible(
                    child: Text(
                      entry["title"]!,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
      options: CarouselOptions(
        height: 245,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 7),
        enlargeCenterPage: true,
        viewportFraction: 0.9,
        onPageChanged: (index, reason) => controller.updateCarouselIndex(index),
      ),
    );
  }

  Widget _buildSmoothIndicator() {
    return Obx(
      () => AnimatedSmoothIndicator(
        activeIndex: controller.currentIndex.value,
        count: controller.carouselData.length,
        effect: const ExpandingDotsEffect(
          dotColor: Colors.grey,
          activeDotColor: Colors.green,
          dotHeight: 8.0,
          dotWidth: 8.0,
          spacing: 8.0,
        ),
      ),
    );
  }

  Widget _buildLocationRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        children: [
          InkWell(
            onTap: () async {
              final selectedLatLng = await Get.toNamed(Routes.MAPS_LOCATION);
              if (selectedLatLng != null && selectedLatLng is LatLng) {
                controller.updateLocation(selectedLatLng);
              }
            },
            child: Row(
              children: const [
                Icon(Icons.location_on, color: Colors.red),
                SizedBox(width: 4),
                Text(
                  "Lokasi: ",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Obx(
                () => Text(
                  controller.address.value,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButtons() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: controller.filterOptions.map((filter) {
          return Obx(
            () => Padding(
              padding: const EdgeInsets.only(right: 10),
              child: SizedBox(
                width: widhtFilter,
                height: heightFilter,
                child: TextButton(
                  onPressed: () => controller.updateSelectedFilter(filter),
                  style: TextButton.styleFrom(
                    backgroundColor: controller.selectedButton.value == filter
                        ? Colors.green.withOpacity(0.8)
                        : Colors.grey.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    filter.capitalizeFirst!,
                    style: TextStyle(
                      color: controller.selectedButton.value == filter
                          ? Colors.white
                          : Colors.green,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildProductGrid() {
    return Obx(
      () => GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 8.0,
          mainAxisExtent: 323,
        ),
        itemCount: controller.filteredProductData.length,
        itemBuilder: (context, index) {
          final product = controller.filteredProductData[index];
          return Padding(
            padding: const EdgeInsets.all(0.5),
            child: ProductCard(
              imageUrl: product["imageUrl"],
              categoryName: product["categoryName"],
              productName: product["productName"],
              price: (product["price"] as num).toDouble(),
              currency: product["currency"],
              soldCount: product["soldCount"],
              onTap: () =>
                  Get.toNamed(Routes.DETAIL_PRODUCT, arguments: product),
              rating: product["rating"],
              cardColor: Colors.white,
              textColor: Colors.black,
              borderRadius: 8.0,
            ),
          );
        },
      ),
    );
  }
}
