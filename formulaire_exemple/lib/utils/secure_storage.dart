import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final _storage = const FlutterSecureStorage();
  static const _keyEmail = 'email';
  static const _keyPassword = 'password';
  static const _keyToken = 'token';
  static const _keyFirstName = 'firstName';
  static const _keyLastName = 'lastName';

  Future<void> saveToken(String token) async {
    await _storage.write(key: _keyToken, value: token);
  }

  Future<void> saveCredentials(String email, String password, String firstName, String lastName) async {
    await _storage.write(key: _keyEmail, value: email);
    await _storage.write(key: _keyPassword, value: password);
    await _storage.write(key: _keyFirstName, value: firstName);
    await _storage.write(key: _keyLastName, value: lastName);
  }

  Future<String?> readToken() async {
    return await _storage.read(key: _keyToken);
  }

  Future<Map<String, String?>> readCredentials() async {
    String? email = await _storage.read(key: _keyEmail);
    String? password = await _storage.read(key: _keyPassword);
    String? firstName = await _storage.read(key: _keyFirstName);
    String? lastName = await _storage.read(key: _keyLastName);
    return {
      'email': email,
      'password': password,
      'firstName' : firstName,
      'lastName' : lastName,
    };
  }

  Future<void> deleteCredentials() async {
    await _storage.delete(key: _keyEmail);
    await _storage.delete(key: _keyPassword);
    await _storage.delete(key: _keyToken);
  }
}
