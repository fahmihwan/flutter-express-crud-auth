import 'package:fe_flutter/services/interceptor.dart';
import '../models/book.dart';
import 'dart:convert';

class BookService {
  final String baseUrl = 'http://192.168.1.8:3000/api';
  final ApiService _apiService = ApiService();

  Future<List<Book>> fetchBook() async {
    final response = await _apiService.api.get('$baseUrl/books');
    final Map<String, dynamic> body = response.data;
    if (response.statusCode == 200) {
      List<dynamic> bookJson = body['data'];
      return bookJson.map((data) => Book.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load book');
    }
  }

  Future<Book> fetchBookById(int id) async {
    final response = await _apiService.api.get('$baseUrl/book/$id');
    final Map<String, dynamic> body = response.data;
    if (response.statusCode == 200) {
      return Book.fromJson(body['data']);
    } else {
      throw Exception("Failed to load book");
    }
  }

  Future<void> createBook(String title) async {
    final response = await _apiService.api
        .post('$baseUrl/book', data: jsonEncode({'title': title}));
    final Map<String, dynamic> body = response.data;
    if (response.statusCode == 200) {
      print('Post created: ${body}');
    } else {
      print('Failed to create post: ${response.statusCode}');
    }
  }

  Future<void> deleteBook(int id) async {
    final response = await _apiService.api.delete('$baseUrl/book/$id');
    if (response.statusCode == 200) {
      print('Post created: ${response.data}');
    } else {
      print('Failed to create post: ${response.statusCode}');
    }
  }

  Future<void> updateBook(int id, String title) async {
    final response = await _apiService.api
        .put('$baseUrl/book/$id', data: jsonEncode({"title": title}));
    if (response.statusCode == 200) {
      print('Post created: ${response.data}');
    } else {
      print('Failed to create post: ${response.statusCode}');
    }
  }
}
