import 'package:api_client/api_client.dart';
import 'package:book_repository/book_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockApiClient extends Mock implements ApiClient {}

class MockBookResource extends Mock implements BookResource {}

void main() {
  group('BookRepository', () {
    late ApiClient apiClient;
    late BookResource bookResource;

    late BookRepository subject;

    setUp(() {
      apiClient = MockApiClient();
      bookResource = MockBookResource();
      when(() => apiClient.bookResource).thenReturn(bookResource);

      subject = BookRepository(apiClient: apiClient);
    });

    group('.fetchBookDetails', () {
      const id = 1;
      const bookResponse = {'id': id, 'name': 'Book 1'};
      const book = Book(id: id, name: 'Book 1');

      test(
        'makes correct request',
        () async {
          when(() => bookResource.fetchBookById(id)).thenAnswer(
            (_) async => bookResponse,
          );

          await subject.fetchBookById(id);

          verify(() => bookResource.fetchBookById(id)).called(1);
        },
      );

      test(
        'returns a Book when bookResource.fetchBookById succeeds',
        () async {
          when(() => bookResource.fetchBookById(id)).thenAnswer(
            (_) async => bookResponse,
          );

          final response = await subject.fetchBookById(id);

          expect(response, isNotNull);
          expect(response, isA<Book>());
          expect(response, equals(book));
        },
      );

      test(
        'throws a FetchBookByIdFailure when bookResource.fetchBookById throws',
        () async {
          when(() => bookResource.fetchBookById(id)).thenThrow(Exception());

          expect(
            () => subject.fetchBookById(id),
            throwsA(isA<FetchBookByIdFailure>()),
          );
        },
      );
    });
  });
}
