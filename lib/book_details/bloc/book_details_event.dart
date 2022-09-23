part of 'book_details_bloc.dart';

abstract class BookDetailsEvent extends Equatable {
  const BookDetailsEvent();
}

class BookDetailsRequested extends BookDetailsEvent {
  const BookDetailsRequested({required this.id});

  final int id;

  @override
  List<Object> get props => [id];
}
