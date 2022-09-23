import 'package:book_repository/book_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/book_details/book_details.dart';

class BookDetailsPage extends StatelessWidget {
  const BookDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return BookDetailsBloc(
          bookRepository: context.read<BookRepository>(),
        )..add(const BookDetailsRequested(id: 1));
      },
      child: const BookDetailsView(),
    );
  }
}
