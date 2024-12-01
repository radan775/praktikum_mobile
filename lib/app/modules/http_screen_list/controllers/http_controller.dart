import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:praktikum/app/data/models/articles.dart';

class HttpController extends GetxController {
  RxList<Article> articles = RxList<Article>([]);
  RxBool isLoading = false.obs;

  @override
  void onInit() async {
    await fetchArticles();
    super.onInit();
  }

  Future<void> fetchArticles() async {
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=a36e94ffa76742469c8ff35e53a43770'));

      if (response.statusCode == 200) {
        final jsonData = response.body;
        final articlesResult = Articles.fromJson(json.decode(jsonData));
        articles.value = articlesResult.articles;
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred :$e');
    } finally {
      isLoading.value = false;
    }
  }
}
