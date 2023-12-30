import 'preferences_service.dart';

class UserSharedPreferences {
  static Future<void> init() async {
    try {
      await PreferencesService.init();
    } on Exception catch (e) {
      print('Error : $e');
    }
  }

  static Future<void> setName(
      {required String name, required String pin}) async {
    await PreferencesService.setName(name: name, pin: pin);
  }

  static String? getName() {
    return PreferencesService.getName();
  }

  static String? getPin() {
    return PreferencesService.getPin();
  }
}
