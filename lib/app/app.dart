import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:advanced_flutter_arabic/app/app_prefs.dart';
import 'package:advanced_flutter_arabic/presentation/resources/theme_manager.dart';
import 'package:advanced_flutter_arabic/presentation/splash/splash_view.dart';

import '../presentation/resources/translations/transelation.dart';

class MyApp extends StatefulWidget {
  // named constructor
  MyApp._internal();

  int appState = 0;

  static final MyApp _instance =
      MyApp._internal(); // singleton or single instance

  factory MyApp() => _instance; // factory

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? locale;
  @override
  Future<void> didChangeDependencies() async {
    AppPreferences.getLocal().then((value) async {
      print('ana wassslt ya regala');
      locale = value;
      Get.updateLocale(value);
      print(locale);
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: locale,
      translations: LocaleString(),
      fallbackLocale: const Locale('en'),
      debugShowCheckedModeBanner: false,
      home: const SplashView(),
      theme: getApplicationTheme(),
    );
  }
}
