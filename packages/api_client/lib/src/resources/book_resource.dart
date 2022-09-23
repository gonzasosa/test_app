/// {@template book_resource}
/// Resource for interacting with Books.
/// {@endtemplate}
class BookResource {
  /// {@macro book_resource}
  BookResource();

  /// Return a JSON object represantation of a book by the given [id].
  ///
  /// If an error occurs, throws an [Exception].
  Future<Map<String, dynamic>> fetchBookById(int id) async {
    const book = {'id': 1, 'name': 'Book 1'};

    try {
      return Future.sync(() => book);
    } on Exception {
      rethrow;
    }
  }
}
