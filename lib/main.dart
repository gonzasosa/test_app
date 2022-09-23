import 'package:api_client/api_client.dart';
import 'package:book_repository/book_repository.dart';
import 'package:flutter/material.dart';
import 'package:test_app/app/app.dart';

void main() {
  const apiClient = ApiClient();
  final bookRepository = BookRepository(apiClient: apiClient);

  runApp(App(bookRepository: bookRepository));
}
