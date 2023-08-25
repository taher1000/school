import 'dart:convert';

import '../../../../../core/network/api_response_model.dart';

import 'teacher_assignment_model.dart';

class TeacherAssignmentSummaryResponsePage extends ApiResponse {
  TeacherAssignmentSummaryResponsePage({
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

  factory TeacherAssignmentSummaryResponsePage.fromRawJson(String str) =>
      TeacherAssignmentSummaryResponsePage.fromJson(json.decode(str));

  factory TeacherAssignmentSummaryResponsePage.fromJson(
          Map<String, dynamic> json) =>
      TeacherAssignmentSummaryResponsePage(
        pageNumber: json["pageNumber"] ?? 1,
        pageSize: json["pageSize"],
        totalRecords: json["totalRecords"],
        data: json["data"] == null
            ? []
            : List<TeacherAssignmentModel>.from(
                json["data"].map((x) => TeacherAssignmentModel.fromJson(x))),
        succeeded: json["succeeded"],
        errors: json["errors"] == null
            ? []
            : List<String>.from(json["errors"]!.map((x) => x)),
        message: json["message"],
        nextPage: json["nextPage"],
        totalPages: json["totalPages"],
      );
}
