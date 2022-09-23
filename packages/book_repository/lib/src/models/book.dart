import 'package:equatable/equatable.dart';

/// {@template book}
/// Model representing a book.
/// {@endtemplate}
class Book extends Equatable {
  /// {@macro book}
  const Book({
    required this.id,
    required this.name,
  });

  /// An empty Book representation.
  static const empty = Book(id: -1, name: '');

  /// Return this book's unique identifier.
  final int id;

  /// Return this book's name.
  final String name;

  @override
  List<Object> get props => [id, name];
}
