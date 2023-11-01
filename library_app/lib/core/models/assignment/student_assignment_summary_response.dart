import 'dart:convert';

import 'student_assignment.dart';

import '../../../../../core/network/api_response_model.dart';


class StudentAssignmentSummaryResponsePage extends ApiResponse {
  StudentAssignmentSummaryResponsePage({
    super.data,
    super.succeeded,
    super.errors,
    super.message,
    required super.pageNumber,
    super.pageSize,
    super.totalRecords,
    super.nextPage,
    super.totalPages,
  });

  factory StudentAssignmentSummaryResponsePage.fromRawJson(String str) =>
      StudentAssignmentSummaryResponsePage.fromJson(json.decode(str));

  factory StudentAssignmentSummaryResponsePage.fromJson(
          Map<String, dynamic> json) =>
      StudentAssignmentSummaryResponsePage(
        pageNumber: json["pageNumber"] ?? 1,
        pageSize: json["pageSize"],
        totalRecords: json["totalRecords"],
        data: json["data"] == null
            ? []
            : List<StudentAssignmentModel>.from(
                json["data"].map((x) => StudentAssignmentModel.fromJson(x))),
        succeeded: json["succeeded"],
        errors: json["errors"] == null
            ? []
            : List<String>.from(json["errors"]!.map((x) => x)),
        message: json["message"],
        nextPage: json["nextPage"],
        totalPages: json["totalPages"],
      );
}
