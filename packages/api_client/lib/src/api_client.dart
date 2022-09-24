import 'package:api_client/api_client.dart';

/// {@template api_client}
/// An API client to communicate with the app backend.
/// {@endtemplate}
class ApiClient {
  /// {@macro api_client}
  const ApiClient();

  /// {@macro book_resource}
  BookResource get bookResource {
    return BookResource();
  }
}
