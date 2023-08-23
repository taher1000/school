import 'package:meta/meta.dart';
import 'dart:convert';

import '../../../main/domain/entities/user_data.dart';

class UserDataModel extends UserData {
  UserDataModel({
    required super.email,
    required super.userName,
    required super.userRole,
    required super.englishFullName,
    required super.arabicFullName,
    required super.birthDate,
    required super.phoneNumber,
    required super.profilePicture,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
        email: json["email"],
        userName: json["userName"],
        userRole: json["userRole"],
        englishFullName: json["englishFullName"],
        arabicFullName: json["arabicFullName"],
        birthDate: DateTime.parse(json["birthDate"]),
        phoneNumber: json["phoneNumber"],
        profilePicture: json["profilePicture"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "userName": userName,
        "userRole": userRole,
        "englishFullName": englishFullName,
        "arabicFullName": arabicFullName,
        "birthDate": birthDate.toIso8601String(),
        "phoneNumber": phoneNumber,
        "profilePicture": profilePicture,
      };
}