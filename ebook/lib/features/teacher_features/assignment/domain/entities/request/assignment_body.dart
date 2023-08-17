import 'package:equatable/equatable.dart';

import 'book_collection_body.dart';

class AssignmentPostRequestBody extends Equatable {
  final String englishName;
  final String arabicName;
  final DateTime startDate;
  final DateTime endDate;
  final int sectionId;
  final List<String> studentIDs;
  final List<BookCollection> bookCollection;

  const AssignmentPostRequestBody({
    required this.englishName,
    required this.arabicName,
    required this.startDate,
    required this.endDate,
    required this.sectionId,
    required this.studentIDs,
    required this.bookCollection,
  });

  @override
  List<Object?> get props => [
        englishName,
        arabicName,
        startDate,
        endDate,
        sectionId,
        studentIDs,
        bookCollection,
      ];
}
