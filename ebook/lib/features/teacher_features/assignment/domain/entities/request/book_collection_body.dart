import 'package:equatable/equatable.dart';

class BookCollection extends Equatable {
  final String bookId;
  final bool hasBookRead;
  final bool hasBookAudio;

  const BookCollection({
    required this.bookId,
    required this.hasBookRead,
    required this.hasBookAudio,
  });

  @override
  List<Object?> get props => [bookId, hasBookRead, hasBookAudio];
}
