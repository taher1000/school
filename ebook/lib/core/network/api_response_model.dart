class ApiResponse {
  late List<dynamic>? data;
  final bool? succeeded;
  final List<String>? errors;
  final int? pageNumber;
  final int? pageSize;
  final int? totalRecords;
  final int? totalPages;
  final bool? nextPage;
  final String? message;

  ApiResponse({
    this.data,
    this.errors,
    this.succeeded,
    this.message,
    this.pageNumber,
    this.pageSize,
    this.totalRecords,
    this.nextPage,
    this.totalPages,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return ApiResponse(
      succeeded: json["succeeded"],
      message: json["message"],
      errors: List<String>.from(json["errors"].map((x) => x)),
      data: json["data"] ?? [],
      pageNumber: json["pageNumber"],
      pageSize: json["pageSize"],
      totalRecords: json["totalRecords"],
      nextPage: json["nextPage"],
      totalPages: json["totalPages"],
    );
  }
}
