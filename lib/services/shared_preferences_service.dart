import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  Future<bool> storeData(String key,dynamic data) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final res = await sp.setString(key, data);
    return res;
  }

  Future<String?> getData(String key) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();

    final res = sp.getString(key);
    return res;
  }
}
