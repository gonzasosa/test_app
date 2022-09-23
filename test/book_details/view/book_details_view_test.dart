import 'package:bloc_test/bloc_test.dart';
import 'package:book_repository/book_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_app/book_details/book_details.dart';

class MockBookDetailsBloc extends MockBloc<BookDetailsEvent, BookDetailsState>
    implements BookDetailsBloc {}

void main() {
  group('PersonalInformationPage', () {
    late BookDetailsBloc bookDetailsBloc;

    setUp(() async {
      bookDetailsBloc = MockBookDetailsBloc();
    });

    testWidgets(
      'renders a CircularProgressIndicator when '
      'BookDetailsBloc.status is [initial]',
      (tester) async {
        when(() => bookDetailsBloc.state).thenReturn(
          const BookDetailsState.initial(),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider.value(
              value: bookDetailsBloc,
              child: const BookDetailsView(),
            ),
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );

    testWidgets(
      'renders a CircularProgressIndicator when '
      'BookDetailsBloc.status is [loading]',
      (tester) async {
        when(() => bookDetailsBloc.state).thenReturn(
          const BookDetailsState(
            book: Book.empty,
            status: BookDetailsStatus.loading,
          ),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider.value(
              value: bookDetailsBloc,
              child: const BookDetailsView(),
            ),
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );

    testWidgets(
      'renders an Error message when '
      'BookDetailsBloc.status is [failure] ',
      (tester) async {
        when(() => bookDetailsBloc.state).thenReturn(
          const BookDetailsState(
            book: Book.empty,
            status: BookDetailsStatus.failure,
          ),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider.value(
              value: bookDetailsBloc,
              child: const BookDetailsView(),
            ),
          ),
        );

        expect(find.text('Error!'), findsOneWidget);
      },
    );

    testWidgets(
      "renders the Book's data when "
      'BookDetailsBloc.status is [success]',
      (tester) async {
        const book = Book(id: 1, name: 'Book');

        when(() => bookDetailsBloc.state).thenReturn(
          const BookDetailsState(
            book: book,
            status: BookDetailsStatus.success,
          ),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider.value(
              value: bookDetailsBloc,
              child: const BookDetailsView(),
            ),
          ),
        );

        expect(find.text('Book id: ${book.id}'), findsOneWidget);
        expect(find.text('Book name: ${book.name}'), findsOneWidget);
      },
    );
  });
}
