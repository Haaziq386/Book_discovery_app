import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService({this.baseUrl = "https://gutendex.com/books/"});

  Future<Map<String, dynamic>> fetchBooks(String? url) async {
    final Uri uri = Uri.parse(url ?? baseUrl);

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load books');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
