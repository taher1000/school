import 'dart:convert';

import '../enums/user_role_enum.dart';

import '../../../../core/enums/user_role.dart';

class UserResponse {
  final String? email;
  final String? userName;
  final UserRole userRole;
  final String? englishFullName;
  final String? arabicFullName;
  final DateTime? birthDate;
  final dynamic phoneNumber;
  final String? token;
  final String? refreshToken;

  UserResponse({
    this.email,
    this.userName,
    required this.userRole,
    this.englishFullName,
    this.arabicFullName,
    this.birthDate,
    this.phoneNumber,
    this.token,
    this.refreshToken,
  });

  factory UserResponse.fromRawJson(String str) =>
      UserResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        email: json["email"],
        userName: json["userName"],
        userRole: UserRole.fromJson(json["userRole"]),
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
  // factory UserResponse.getImageFromJson(Map<String, dynamic> json) => UserResponse(
  //       userImage: json["data"]["civilImageUrl"] ?? "",
  //     );
}
