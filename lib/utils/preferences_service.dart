import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static SharedPreferences? _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<void> setName({
    required String name,
    required String pin,
  }) async {
    if (_preferences != null) {
      await _preferences!.setString('name', name);
      await _preferences!.setString('pin', pin);
    }
  }

  static String? getName() {
    if (_preferences != null) {
      return _preferences!.getString('name');
    }
    return null;
  }

  static String? getPin() {
    if (_preferences != null) {
      return _preferences!.getString('pin');
    }
    return null;
  }
}

class UserSharedPreferences {
  static Future<void> init() async {
    try {
      await PreferencesService.init();
    } on Exception catch (e) {
      print('Error: $e');
    }
  }

  // other methods
}
