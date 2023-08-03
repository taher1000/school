class UserTermsAgreementResponse {
  UserTermsAgreementResponse({
    this.nationalId,
    this.agreed,
    this.createdDate,
  });

  String? nationalId;
  bool? agreed;
  DateTime? createdDate;

  factory UserTermsAgreementResponse.fromJson(Map<String, dynamic> json) =>
      UserTermsAgreementResponse(
        nationalId: json["nationalID"],
        agreed: json["agreed"] ?? false,
        createdDate: DateTime.parse(json["created_Date"]),
      );
}
