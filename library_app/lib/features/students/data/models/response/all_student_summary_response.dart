import 'dart:convert';

import '../../../../../core/network/api_response_model.dart';
import '../student.dart';

class AllStudentsSummaryResponsePage extends ApiResponse {
  @override
  final List<StudentModel> data;

  AllStudentsSummaryResponsePage({
    required this.data,
    super.succeeded,
    super.errors,
    super.message,
    required super.pageNumber,
    super.pageSize,
    super.totalRecords,
    super.nextPage,
    super.totalPages,
  }) : super(data: data);

  factory AllStudentsSummaryResponsePage.fromRawJson(String str) =>
      AllStudentsSummaryResponsePage.fromJson(json.decode(str));

  factory AllStudentsSummaryResponsePage.fromJson(Map<String, dynamic> json) =>
      AllStudentsSummaryResponsePage(
        pageNumber: json["pageNumber"] ?? 1,
        pageSize: json["pageSize"],
        totalRecords: json["totalRecords"],
        data: json["data"] == null
            ? []
            : List<StudentModel>.from(
                json["data"].map((x) => StudentModel.fromJson(x))),
        succeeded: json["succeeded"],
        errors: json["errors"] == null
            ? []
            : List<String>.from(json["errors"]!.map((x) => x)),
        message: json["message"],
        nextPage: json["nextPage"],
        totalPages: json["totalPages"],
      );
}
