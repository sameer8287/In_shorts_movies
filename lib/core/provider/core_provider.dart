import 'package:flutter/cupertino.dart';
import '../utils/shared_prefrence_utils.dart';

class CoreProvider extends ChangeNotifier {

  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  /// Sets locale and saves it to shared preferences
  Future<void> setLocale(String languageCode) async {
    _locale = Locale(languageCode);
    await SharedPrefUtils.setValue("language", languageCode);
    notifyListeners();
  }
}