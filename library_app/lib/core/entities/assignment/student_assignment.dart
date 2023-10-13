import '../book/book.dart';

class StudentAssignment extends Book {
  final String assignmentId;
  final String assignmentEnglishName;
  final String assignmentArabicName;
  final DateTime assignmentStartDate;
  final DateTime assignmentEndDate;
  final bool hasAssignmentExpired;
  final DateTime assignmentCreatedDate;
  final bool hasGeneralLevelPass;
  final bool hasDeductiveLevelPass;
  final bool hasEvaluativeLevelPass;
  final bool showAdvanceQuestion;
  const StudentAssignment({
    required this.showAdvanceQuestion,
    required this.assignmentId,
    required this.assignmentArabicName,
    required this.assignmentEnglishName,
    required this.hasAssignmentExpired,
    required this.hasGeneralLevelPass,
    required this.hasDeductiveLevelPass,
    required this.hasEvaluativeLevelPass,
    required this.assignmentStartDate,
    required this.assignmentEndDate,
    required this.assignmentCreatedDate,
    required super.id,
    required super.title,
    required super.description,
    required super.bookLevel,
    required super.image,
    required super.bookLanguage,
    required super.pageCount,
    required super.wordCount,
    required super.isActive,
    required super.authorName,
    required super.authorAddress,
    required super.publisherName,
    required super.publisherAddress,
    required super.imageId,
    required super.hasListening,
    required super.hasReading,
    required super.hasReadingCompleted,
    required super.hasListeningCompleted,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        bookLevel,
        image,
        bookLanguage,
        pageCount,
        wordCount,
        isActive,
        authorName,
        authorAddress,
        publisherName,
        publisherAddress,
        imageId,
        hasReading,
        hasListening,
        hasReadingCompleted,
        hasListeningCompleted,
        showAdvanceQuestion,
        assignmentId,
        assignmentArabicName,
        assignmentEnglishName,
        hasAssignmentExpired,
        hasGeneralLevelPass,
        hasDeductiveLevelPass,
        hasEvaluativeLevelPass,
        assignmentStartDate,
        assignmentEndDate,
        assignmentCreatedDate,
      ];
}
