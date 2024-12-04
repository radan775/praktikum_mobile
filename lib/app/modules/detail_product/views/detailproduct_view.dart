import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:praktikum/app/modules/detail_product/controllers/detailproduct_controller.dart';

class DetailProductView extends GetView<DetailproductController> {
  const DetailProductView({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> product = {
      "images": [
        "https://www.swiss-farmers.ch/app/uploads/2023/10/schweizer-baeuerinnen-und-bauern_rindvieh-1200x900.jpg",
        "https://cdn0-production-images-kly.akamaized.net/E05Bi-7oLNwxsLvGTWE8rITW5w0=/0x130:1920x1212/1200x675/filters:quality(75):strip_icc():format(jpeg)/kly-media-production/medias/4048720/original/077671600_1654846143-pexels-pixabay-248337.jpg",
      ],
      "categoryName": "Sapi",
      "productName": "Men Linen Pants",
      "price": 21500000,
      "currency": "Rp",
      "shortDescription": "Comfortable & airy.",
      "rating": 4.2,
      "discountPercentage": 35.0,
      "sold": 165,
    };

    final PageController pageController = PageController();
    final ValueNotifier<int> currentIndex = ValueNotifier<int>(0);
    final ValueNotifier<bool> isFavorite = ValueNotifier<bool>(false);

    // Fungsi untuk format harga
    String formatCurrency(int price) {
      final formatter = NumberFormat("#,###", "id_ID");
      return formatter.format(price);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Product',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 4,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bagian Gambar Geser dengan PageView
            SizedBox(
              height: 300,
              child: PageView.builder(
                controller: pageController,
                itemCount: product["images"].length,
                onPageChanged: (index) {
                  currentIndex.value = index;
                },
                itemBuilder: (context, index) {
                  return Image.network(
                    product["images"][index],
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            // Indikator titik-titik
            ValueListenableBuilder<int>(
              valueListenable: currentIndex,
              builder: (context, value, _) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    product["images"].length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: value == index ? 12 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: value == index ? Colors.teal : Colors.grey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Bagian Harga
                  Row(
                    children: [
                      Text(
                        '${product["currency"]}${formatCurrency(product["price"])}',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${product["currency"]}${formatCurrency((product["price"] * (1 - product["discountPercentage"] / 100)).toInt())}',
                        style: const TextStyle(
                          fontSize: 16,
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          product["productName"],
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      ValueListenableBuilder<bool>(
                        valueListenable: isFavorite,
                        builder: (context, value, _) {
                          return IconButton(
                            icon: Icon(
                              value
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_outline_rounded,
                              color: value ? Colors.red : Colors.grey,
                            ),
                            onPressed: () {
                              isFavorite.value = !value;
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4), // Ukuran padding lebih kecil
                        decoration: BoxDecoration(
                          color: Colors.green.shade50, // Warna latar belakang
                          borderRadius:
                              BorderRadius.circular(7), // Sudut melengkung
                        ),
                        child: Text(
                          product["categoryName"],
                          style: const TextStyle(
                            fontSize:
                                14, // Ukuran teks lebih kecil untuk konsistensi
                            fontWeight: FontWeight.w500,
                            color: Colors.grey, // Warna teks menyesuaikan
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'Terjual ${NumberFormat.decimalPattern("id_ID").format(product["sold"])}',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight
                                  .w500, // Menambah ketebalan untuk penekanan
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(
                              width: 6), // Memberi jarak antara teks dan simbol
                          const Text(
                            "•",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey, // Warna simbol lebih lembut
                            ),
                          ),
                          const SizedBox(
                              width: 6), // Memberi jarak antara simbol dan teks
                          const Icon(
                            Icons.star, // Ikon bintang
                            size: 18, // Ukuran ikon sesuai dengan teks
                            color: Colors.orange, // Warna ikon bintang
                          ),
                          const SizedBox(
                              width: 4), // Memberi jarak antara ikon dan rating
                          Text(
                            '${product["rating"]}',
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 5), // Spasi antara elemen
            Divider(
              thickness: 8,
              color: const Color.fromARGB(255, 215, 211, 211),
            ),
            Row(
              children: [
                ClipOval(
                  child: Image.network(
                    'https://marketplace.canva.com/EAGEp9FN8Vk/4/0/1600w/canva-coklat-kuning-lingkaran-peternakan-kambing-logo-Ms9_XRPhoAo.jpg',
                    width: 80, // Lebar logo
                    height: 80, // Tinggi logo
                    fit: BoxFit.cover, // Menyesuaikan gambar di dalam lingkaran
                  ),
                ),
                Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Mengatur teks rata kiri
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.store, // Ikon toko
                          size: 18, // Ukuran ikon
                          color: Colors.black, // Warna ikon
                        ),
                        SizedBox(width: 5), // Jarak antara ikon dan teks
                        Text(
                          'Nama Toko', // Ganti dengan nama toko Anda
                          style: TextStyle(
                            fontSize: 16, // Ukuran font
                            fontWeight: FontWeight.bold, // Ketebalan font
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Jl. natural, kelurahan planet', // Ganti dengan alamat toko Anda
                      style: TextStyle(
                        fontSize: 14, // Ukuran font alamat
                        color: Colors.black
                            .withOpacity(0.6), // Warna hitam dengan opacity
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Divider(
              thickness: 8,
              color: const Color.fromARGB(255, 215, 211, 211),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Deskripsi Produk',
                    style: TextStyle(
                      fontSize: 18, // Ukuran font untuk judul
                      fontWeight: FontWeight.bold, // Membuat teks tebal
                      color: Colors.black, // Warna teks
                    ),
                  ),
                  const SizedBox(
                      height: 8), // Memberikan jarak antara judul dan teks
                  const Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque a mattis nunc, vel molestie sem. Etiam tristique tellus et nisl varius, ut fringilla ligula dapibus. Nulla nec dui ac nibh laoreet faucibus. Vestibulum et condimentum lorem. Donec mattis hendrerit pretium. Fusce scelerisque in mauris eu pretium. Duis eleifend nisl quis elit aliquet, ac vestibulum odio dapibus. Nunc congue nunc a neque ullamcorper sodales. Donec tincidunt nisi sit amet sapien auctor, sit amet elementum neque efficitur. Sed volutpat ipsum dignissim ultrices vestibulum. Quisque luctus vel felis ac pharetra. Interdum et malesuada fames ac ante ipsum primis in faucibus. Praesent eu interdum.',
                    style: TextStyle(
                      fontSize: 14, // Ukuran font untuk deskripsi
                      color: Colors.black87, // Warna teks untuk deskripsi
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon Chat Button
            ElevatedButton(
              onPressed: () {
                print("TOMBOL CHAT");
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                backgroundColor: const Color(0xFF56ab2f),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Icon(Icons.chat, color: Colors.white),
            ),
            const SizedBox(width: 16),
            // Add to Cart Button
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  print("TAMBAH KERANJANG");
                },
                icon: const Icon(Icons.shopping_cart),
                label: const Text('+ keranjang'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  backgroundColor: const Color(0xFF56ab2f),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
