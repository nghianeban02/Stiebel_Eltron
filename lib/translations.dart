import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:convert';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {};

  static Future<void> loadTranslations() async {
    final enUs = await rootBundle.loadString('assets/translations/en_US.json');
    final viVn = await rootBundle.loadString('assets/translations/vi_VN.json');
    final geGN = await rootBundle.loadString('assets/translations/ge_GN.json');
    final enUsMap = Map<String, String>.from(json.decode(enUs));
    final viVnMap = Map<String, String>.from(json.decode(viVn)); 
    final geGNMap = Map<String, String>.from(json.decode(geGN));
    Get.addTranslations({
      'en_US': enUsMap,
      'vi_VN': viVnMap,
       'ge_GN': geGNMap,
    });
  }
}
