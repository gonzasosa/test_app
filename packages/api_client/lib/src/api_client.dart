import 'package:api_client/api_client.dart';

/// {@template api_client}
/// Api Client exposing all different set of resources.
/// {@endtemplate}
class ApiClient {
  /// {@macro api_client}
  const ApiClient();

  /// Returns the book resource.
  BookResource get bookResource {
    return BookResource();
  }
}
