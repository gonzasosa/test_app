import 'package:book_repository/book_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'book_details_event.dart';
part 'book_details_state.dart';

class BookDetailsBloc extends Bloc<BookDetailsEvent, BookDetailsState> {
  BookDetailsBloc({required BookRepository bookRepository})
      : _bookRepository = bookRepository,
        super(const BookDetailsState.initial()) {
    on<BookDetailsRequested>(_onBookDetailsRequested);
  }

  final BookRepository _bookRepository;

  Future<void> _onBookDetailsRequested(
    BookDetailsRequested event,
    Emitter<BookDetailsState> emit,
  ) async {
    emit(state.copyWith(status: BookDetailsStatus.loading));

    try {
      final book = await _bookRepository.fetchBookById(event.id);
      emit(
        state.copyWith(
          book: book,
          status: BookDetailsStatus.success,
        ),
      );
    } on FetchBookByIdFailure {
      emit(state.copyWith(status: BookDetailsStatus.failure));
    }
  }
}
