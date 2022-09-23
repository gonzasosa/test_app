import 'package:book_repository/book_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/book_details/book_details.dart';

class App extends StatelessWidget {
  const App({super.key, required BookRepository bookRepository})
      : _bookRepository = bookRepository;

  final BookRepository _bookRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _bookRepository,
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BookDetailsPage(),
    );
  }
}
