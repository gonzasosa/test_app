import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/book_details/book_details.dart';

class BookDetailsView extends StatelessWidget {
  const BookDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<BookDetailsBloc>().state;
    final status = state.status;

    if (status.isInitial || status.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    }

    if (status.isFailure) {
      return const Scaffold(
        body: Center(
          child: Text('Error!'),
        ),
      );
    }

    final book = state.book;
    return Scaffold(
      body: Column(
        children: [
          Text('Book id: ${book.id}'),
          const SizedBox(height: 16),
          Text('Book name: ${book.name}'),
        ],
      ),
    );
  }
}
