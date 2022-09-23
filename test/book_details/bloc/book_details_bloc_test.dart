import 'package:bloc_test/bloc_test.dart';
import 'package:book_repository/book_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_app/book_details/book_details.dart';

class MockBookRepository extends Mock implements BookRepository {}

void main() {
  group('BookDetailsBloc', () {
    const id = 1;
    const book = Book(id: id, name: 'Book 1');

    late BookRepository bookRepository;

    setUp(() {
      bookRepository = MockBookRepository();
    });

    test('has valid initial state', () {
      expect(
        BookDetailsBloc(bookRepository: bookRepository).state,
        equals(const BookDetailsState.initial()),
      );
    });

    blocTest<BookDetailsBloc, BookDetailsState>(
      'calls bookRepository.fetchBookDetails',
      act: (bloc) => bloc.add(const BookDetailsRequested(id: id)),
      build: () {
        when(() => bookRepository.fetchBookById(id)).thenAnswer(
          (_) async => book,
        );
        return BookDetailsBloc(bookRepository: bookRepository);
      },
      verify: (_) {
        verify(() => bookRepository.fetchBookById(id)).called(1);
      },
    );

    blocTest<BookDetailsBloc, BookDetailsState>(
      'emits [loading, success] when bookRepository.fetchBookDetails succeeds',
      act: (bloc) => bloc.add(const BookDetailsRequested(id: id)),
      build: () {
        when(() => bookRepository.fetchBookById(id)).thenAnswer(
          (_) async => book,
        );
        return BookDetailsBloc(bookRepository: bookRepository);
      },
      expect: () => [
        const BookDetailsState(
          book: Book.empty,
          status: BookDetailsStatus.loading,
        ),
        const BookDetailsState(
          book: book,
          status: BookDetailsStatus.success,
        ),
      ],
    );

    blocTest<BookDetailsBloc, BookDetailsState>(
      'emits [loading, failure] when bookRepository.fetchBookDetails '
      'throws FetchBookByIdFailure',
      act: (bloc) => bloc.add(const BookDetailsRequested(id: id)),
      build: () {
        when(() => bookRepository.fetchBookById(id)).thenThrow(
          FetchBookByIdFailure(
            error: Object(),
            stackTrace: StackTrace.fromString('stackTraceString'),
          ),
        );
        return BookDetailsBloc(bookRepository: bookRepository);
      },
      expect: () => [
        const BookDetailsState(
          book: Book.empty,
          status: BookDetailsStatus.loading,
        ),
        const BookDetailsState(
          book: Book.empty,
          status: BookDetailsStatus.failure,
        ),
      ],
    );
  });
}
