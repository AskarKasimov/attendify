import 'package:flutter_app/features/auth/domain/repositories/secure_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageImpl implements SecureStorage {
  const SecureStorageImpl({
    required final FlutterSecureStorage flutterSecureStorage,
  }) : _flutterSecureStorage = flutterSecureStorage;

  final FlutterSecureStorage _flutterSecureStorage;

  @override
  Future<void> write({
    required final String key,
    required final String value,
  }) async {
    await _flutterSecureStorage.write(key: key, value: value);
  }

  @override
  Future<String?> read({required final String key}) =>
      _flutterSecureStorage.read(key: key);

  @override
  Future<void> delete({required final String key}) async {
    await _flutterSecureStorage.delete(key: key);
  }

  @override
  Future<void> clear() async {
    await _flutterSecureStorage.deleteAll();
  }
}
