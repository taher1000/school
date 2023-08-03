import 'dart:convert';

class UserDataResponse {
  final String? email;
  final String? userName;
  final int? userRole;
  final String? englishFullName;
  final String? arabicFullName;
  final DateTime? birthDate;
  final dynamic phoneNumber;
  final String? token;
  final String? refreshToken;

  UserDataResponse({
    this.email,
    this.userName,
    this.userRole,
    this.englishFullName,
    this.arabicFullName,
    this.birthDate,
    this.phoneNumber,
    this.token,
    this.refreshToken,
  });

  factory UserDataResponse.fromRawJson(String str) =>
      UserDataResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserDataResponse.fromJson(Map<String, dynamic> json) =>
      UserDataResponse(
        email: json["email"],
        userName: json["userName"],
        userRole: json["userRole"],
        englishFullName: json["englishFullName"],
        arabicFullName: json["arabicFullName"],
        birthDate: json["birthDate"] == null
            ? null
            : DateTime.parse(json["birthDate"]),
        phoneNumber: json["phoneNumber"],
        token: json["token"],
        refreshToken: json["refreshToken"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "userName": userName,
        "userRole": userRole,
        "englishFullName": englishFullName,
        "arabicFullName": arabicFullName,
        "birthDate": birthDate?.toIso8601String(),
        "phoneNumber": phoneNumber,
        "token": token,
        "refreshToken": refreshToken,
      };
}
