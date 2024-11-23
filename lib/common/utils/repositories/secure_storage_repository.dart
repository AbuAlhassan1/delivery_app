import 'package:delivery/common/utils/interfaces/storage_interface.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageRepository implements StorageInterFace {
  final secureStorage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
      resetOnError: true,
    ),
  );

  @override
  Future<void> delete(String key) async {
    await secureStorage.delete(key: key);
  }

  @override
  Future<void> deleteAll() async {
    await secureStorage.deleteAll();
  }

  @override
  Future<String?> read(String key) async {
    try {
      return await secureStorage.read(key: key);
    } catch (e) {
      if (e is PlatformException && e.code == 'BadPaddingException') {
        await secureStorage.deleteAll();
        return null;
      }
    }
  }

  @override
  Future<Map<String, String>> readAll(Map data) async {
    return await secureStorage.readAll();
  }

  @override
  Future<void> store(String key, String value) async {
    await secureStorage.write(key: key, value: value);
  }
}
