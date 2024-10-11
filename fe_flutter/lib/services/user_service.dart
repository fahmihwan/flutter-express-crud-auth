import 'dart:convert';
import 'package:fe_flutter/services/interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  final ApiService _apiService = ApiService();

  Future<void> login(String username, String password) async {
    try {
      final response = await _apiService.api.post('/login',
          data: jsonEncode({'username': username, 'password': password}));

      final Map<String, dynamic> body = response.data;

      String token = body['data']['token'];
      await saveUserId(body['data']['user']['id']);
      await saveToken(token);
    } catch (e) {
      print('Error: $e'); // Tangani kesalahan
    }
  }

  Future<void> saveUserId(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', userId);
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
}
