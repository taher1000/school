import '../../../domain/entities/request/assignment_post_request.dart';
import '../../../domain/entities/request/book_collection_body.dart';
import '../../../domain/entities/request/student_list.dart';

class AssignmentPostRequestBodyModel extends AssignmentPostRequestBody {
  const AssignmentPostRequestBodyModel({
    required super.englishName,
    required super.arabicName,
    required super.startDate,
    required super.endDate,
    required super.studentList,
    required super.bookCollection,
  });

  factory AssignmentPostRequestBodyModel.fromJson(Map<String, dynamic> json) =>
      AssignmentPostRequestBodyModel(
        englishName: json["englishName"],
        arabicName: json["arabicName"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        studentList: List<StudentList>.from(
            json["studentList"].map((x) => StudentListModel.fromJson(x))),
        bookCollection: List<BookCollectionModel>.from(
            json["bookCollection"].map((x) => BookCollectionModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "englishName": englishName,
        "arabicName": arabicName,
        "startDate":
            "${startDate?.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "endDate":
            "${endDate?.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "studentList": (studentList)!.map((x) => x.toModel().toJson()).toList(),

        "bookCollection":
            (bookCollection)!.map((x) => x.toModel().toJson()).toList()
        //  List<BookCollectionModel>.from(
        //     bookCollection!.map((x) => x.toModel().toJson())),
      };
}

class BookCollectionModel extends BookCollection {
  const BookCollectionModel({
    required super.bookId,
    required super.hasBookRead,
    required super.hasBookAudio,
  });

  factory BookCollectionModel.fromJson(Map<String, dynamic> json) =>
      BookCollectionModel(
        bookId: json["bookID"],
        hasBookRead: json["hasBookRead"],
        hasBookAudio: json["hasBookAudio"],
      );

  Map<String, dynamic> toJson() => {
        "bookID": bookId,
        "hasBookRead": hasBookRead,
        "hasBookAudio": hasBookAudio,
      };
}

class StudentListModel extends StudentList {
  const StudentListModel({
    required super.studentId,
    required super.classYearId,
    required super.classSectionId,
  });

  factory StudentListModel.fromJson(Map<String, dynamic> json) =>
      StudentListModel(
        studentId: json["studentID"],
        classYearId: json["classYearID"],
        classSectionId: json["classSectionID"],
      );

  Map<String, dynamic> toJson() => {
        "studentID": studentId,
        "classYearID": classYearId,
        "classSectionID": classSectionId,
      };
}
