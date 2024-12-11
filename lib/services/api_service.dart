import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';
import '../models/book_model.dart';

class ApiProvider {
  ApiProvider();

  Future<List<BookModel>> fetchBooks(int page, int pageSize) async {
    final response = await http.get(Uri.parse(
        "$baseUrl/?page=$page&_limit=$pageSize")); //haven't used the _limit parameter

    final responseBody = processResponse(response);
    Map<String, dynamic> jsonResponse = json.decode(responseBody);

    // Extract the books list from the map
    List<dynamic> books = jsonResponse['results'] ?? [];

    // Map the list of books to BookModel
    return books.map((book) => BookModel.fromJson(book)).toList();
  }

  Future<List<BookModel>> searchBooks(String query) async {
    final response = await http.get(
      Uri.parse("$baseUrl/?search=$query"),
    );

    final responseBody = processResponse(response);
    Map<String, dynamic> jsonResponse = json.decode(responseBody);

    // Extract the books list from the map
    List<dynamic> books = jsonResponse['results'] ?? [];

    return books.map((book) => BookModel.fromJson(book)).toList();
  }

  String processResponse(http.Response response) {
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
          'Failed to load books with status code ${response.statusCode}');
    }
  }
}
