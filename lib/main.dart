import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:praktikum/app/data/widgets/theme_controller.dart';
import 'package:praktikum/dependency_injection.dart';
import 'package:praktikum/firebase_options.dart';
import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  initializeDateFormatting('id_ID', null);
  final themeController = Get.put(ThemeController());

  runApp(
    Obx(() {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Application",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        theme: ThemeData.light(), // Tema Light
        darkTheme: ThemeData.dark(), // Tema Dark
        themeMode: themeController.isDarkMode.value
            ? ThemeMode.dark
            : ThemeMode.light, // Mode tema
      );
    }),
  );
  DependencyInjection.init();
}
