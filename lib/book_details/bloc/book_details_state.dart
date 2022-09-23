part of 'book_details_bloc.dart';

enum BookDetailsStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == BookDetailsStatus.initial;
  bool get isLoading => this == BookDetailsStatus.loading;
  bool get isSuccess => this == BookDetailsStatus.success;
  bool get isFailure => this == BookDetailsStatus.failure;
}

class BookDetailsState extends Equatable {
  const BookDetailsState({
    required this.book,
    required this.status,
  });

  const BookDetailsState.initial()
      : this(
          book: Book.empty,
          status: BookDetailsStatus.initial,
        );

  final Book book;
  final BookDetailsStatus status;

  BookDetailsState copyWith({
    Book? book,
    BookDetailsStatus? status,
  }) {
    return BookDetailsState(
      book: book ?? this.book,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [book, status];
}
