part of 'reader_bloc.dart';

abstract class ReaderEvent extends Equatable {
  const ReaderEvent();

  @override
  List<Object> get props => [];
}

class GetBookContentEvent extends ReaderEvent {
  final BookContentParams bookContentParams;
  const GetBookContentEvent({required this.bookContentParams});
}
