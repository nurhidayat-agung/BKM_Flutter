import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageHelper {
  final storage = const FlutterSecureStorage();

  Future setString(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  Future<String?> getString(String key) async {
    return await storage.read(key: key);
  }

}