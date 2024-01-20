import 'package:get/get.dart';

class LanguageController extends GetxController {
  RxString currentLocale = 'en'.obs;
  final value = 'English'.obs;

  void updateLocale(String locale) {
    currentLocale.value = locale;
    if (locale == 'en') {
      value.value = 'English';
    } else if (locale == 'hi') {
      value.value = 'हिंदी';
    } else if (locale == 'te') {
      value.value = 'తెలుగు';
    }
  }
}