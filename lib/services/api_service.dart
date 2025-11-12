import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://api-dev.berkatkarimar.co.id/api';

  Future<Map<String, dynamic>?> login(String phone, String password) async {
    try {
      final url = Uri.parse('$baseUrl/login');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'X-Client-Type': 'mobile',
        },
        body: jsonEncode({
          'phone': phone,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        // Cek login sukses
        if (jsonData['status'] == 'success') {
          final user = jsonData['data']['user'];
          final token = jsonData['data']['token'];

          // Kembalikan data user
          return {
            'id': user['id'],
            'name': user['name'],
            'phone': user['phone'],
            'role': user['roles'][0]['name'],
            'token': token,
          };
        } else {
          return null; // status != success
        }
      } else {
        print('Login gagal: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Terjadi kesalahan: $e');
      return null;
    }
  }
}
