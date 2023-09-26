import '../../data/enums/user_role_enum.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/enums/user_role.dart';

class User extends Equatable {
  final String? email;
  final String? userName;
  final UserRole userRole;
  final String? englishFullName;
  final String? arabicFullName;
  final DateTime? birthDate;
  final String? phoneNumber;
  final String? token;
  final String? refreshToken;
  final String? image;

  const User({
    this.email,
    this.userName,
    required this.userRole,
    this.englishFullName,
    this.arabicFullName,
    this.birthDate,
    this.phoneNumber,
    this.token,
    this.refreshToken,
    this.image,
  });

  User copyWith({
    String? email,
    String? userName,
    UserRole? userRole,
    String? englishFullName,
    String? arabicFullName,
    DateTime? birthDate,
    String? phoneNumber,
    String? token,
    String? refreshToken,
    String? image,
  }) =>
      User(
        email: email ?? this.email,
        userName: userName ?? this.userName,
        userRole: userRole ?? this.userRole,
        englishFullName: englishFullName ?? this.englishFullName,
        arabicFullName: arabicFullName ?? this.arabicFullName,
        birthDate: birthDate ?? this.birthDate,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        token: token ?? this.token,
        refreshToken: refreshToken ?? this.refreshToken,
        image: image ?? this.image,
      );

  @override
  List<Object?> get props => [
        email,
        userName,
        userRole,
        englishFullName,
        arabicFullName,
        birthDate,
        phoneNumber,
        token,
        refreshToken,
        image,
      ];
}
