import 'package:shared_preferences/shared_preferences.dart';

import 'simple_store.dart';

class SharedPreferencesStore implements SimpleStore {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  SharedPreferencesStore();

  /// Save an integer value
  @override
  Future<bool> setInt(String key, int value) async {
    final SharedPreferences prefs = await _prefs;
    return await prefs.setInt(key, value);
  }

  /// Get an integer value
  @override
  Future<int?> getInt(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getInt(key);
  }

  /// Save an boolean value
  @override
  Future<bool> setBool(String key, bool value) async {
    final SharedPreferences prefs = await _prefs;
    return await prefs.setBool(key, value);
  }

  /// Get an boolean value
  @override
  Future<bool?> getBool(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getBool(key);
  }

  @override
  Future<double?> getDouble(String key) {
    // TODO: implement getDouble
    throw UnimplementedError();
  }

  @override
  Future<String?> getString(String key) {
    // TODO: implement getString
    throw UnimplementedError();
  }

  @override
  Future<List<String>?> getStringList(String key) {
    // TODO: implement getStringList
    throw UnimplementedError();
  }

  @override
  Future<bool> setDouble(String key, double value) {
    // TODO: implement setDouble
    throw UnimplementedError();
  }

  @override
  Future<bool> setString(String key, String value) {
    // TODO: implement setString
    throw UnimplementedError();
  }

  @override
  Future<bool> setStringList(String key, List<String> value) {
    // TODO: implement setStringList
    throw UnimplementedError();
  }
}
