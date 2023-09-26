import 'dart:convert';

import 'follow_up_student.dart';

import '../../../../../../core/network/api_response_model.dart';

class FollowUpAssignmentSummaryResponsePage extends ApiResponse {
  FollowUpAssignmentSummaryResponsePage({
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

  factory FollowUpAssignmentSummaryResponsePage.fromRawJson(String str) =>
      FollowUpAssignmentSummaryResponsePage.fromJson(json.decode(str));

  factory FollowUpAssignmentSummaryResponsePage.fromJson(
          Map<String, dynamic> json) =>
      FollowUpAssignmentSummaryResponsePage(
        pageNumber: json["pageNumber"] ?? 1,
        pageSize: json["pageSize"],
        totalRecords: json["totalRecords"],
        data: json["data"] == null
            ? []
            : List<FollowUpStudentModel>.from(
                json["data"].map((x) => FollowUpStudentModel.fromJson(x))),
        succeeded: json["succeeded"],
        errors: json["errors"] == null
            ? []
            : List<String>.from(json["errors"]!.map((x) => x)),
        message: json["message"],
        nextPage: json["nextPage"],
        totalPages: json["totalPages"],
      );
}
