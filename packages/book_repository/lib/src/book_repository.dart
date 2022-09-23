import 'package:api_client/api_client.dart';
import 'package:equatable/equatable.dart';
import 'package:book_repository/book_repository.dart';

/// {@template book_exception}
/// Base class for all [BookRepository]'s [Exception]s.
/// {@endtemplate}
abstract class BookException extends Equatable implements Exception {
  /// {@macro book_exception}
  const BookException({
    required this.error,
    required this.stackTrace,
  });

  /// Return the error.
  final Object error;

  /// Return the stack trace.
  final StackTrace stackTrace;

  @override
  List<Object?> get props => [error, stackTrace];
}

class FetchBookByIdFailure extends BookException {
  const FetchBookByIdFailure({
    required super.error,
    required super.stackTrace,
  });
}

/// {@template book_repository}
/// Repository for the [Book] domain.
/// {@endtemplate}
class BookRepository {
  /// {@macro book_repository}
  BookRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  final ApiClient _apiClient;

  /// Return the [Book] owner of the given [id].
  ///
  /// If an error occurs, throws an [FetchBookByIdFailure].
  Future<Book> fetchBookById(int id) async {
    try {
      final response = await _apiClient.bookResource.fetchBookById(id);
      return Book(
        id: response['id'],
        name: response['name'],
      );
    } catch (error, stackTrace) {
      throw FetchBookByIdFailure(
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}
