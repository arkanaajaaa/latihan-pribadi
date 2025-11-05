import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latihan_pribadiiflutter/models/Loginmodel.dart';

class AuthService {
  // Base URL API
  static const String baseUrl = 'https://mediadwi.com/api/latihan';

  // Method untuk login
  static Future<Loginmodel> login({
    required String username,
    required String password,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/login');

      // Kirim POST request
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'username': username,
          'password': password,
        },
      );

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        // Parse response JSON
        final jsonData = json.decode(response.body);
        return Loginmodel.fromJson(jsonData);
      } else {
        // Jika gagal, return dengan status false
        return Loginmodel(
          status: false,
          message: 'Login gagal: ${response.statusCode}',
          token: '',
        );
      }
    } catch (e) {
      print('Error during login: $e');
      return Loginmodel(
        status: false,
        message: 'Terjadi kesalahan: $e',
        token: '',
      );
    }
  }

  // Method untuk validasi token (optional)
  static Future<bool> validateToken(String token) async {
    try {
      final url = Uri.parse('$baseUrl/validate-token');

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error validating token: $e');
      return false;
    }
  }
}