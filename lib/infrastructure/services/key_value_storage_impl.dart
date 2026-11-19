import 'package:aegis/infrastructure/services/key_value_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeyValueStorageImpl implements KeyValueStorage {
  @override
  Future<bool> removeKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  @override
  Future<void> setKeyValue<T>(String key, T value) async {
    final prefs = await SharedPreferences.getInstance();
    
    if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is String) {
      await prefs.setString(key, value);
    } else if (value is List<String>) {
      await prefs.setStringList(key, value);
    } else {
      throw ArgumentError('Tipo no soportado: $T');
    }
  }

  @override
  Future<T?> getValue<T>(String key) async {
    final prefs = await SharedPreferences.getInstance();
    
    if (T == int) {
      return prefs.getInt(key) as T?;
    } else if (T == bool) {
      return prefs.getBool(key) as T?;
    } else if (T == double) {
      return prefs.getDouble(key) as T?;
    } else if (T == String) {
      return prefs.getString(key) as T?;
    } else if (T == List<String>) {
      return prefs.getStringList(key) as T?;
    } else {
      throw ArgumentError('Tipo no soportado: $T');
    }
  }
}