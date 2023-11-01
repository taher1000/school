import 'package:equatable/equatable.dart';

class TeacherData extends Equatable {
  final String email;
  final String userName;
  final int userRole;
  final String englishFullName;
  final String arabicFullName;
  final DateTime birthDate;
  final String? phoneNumber;
  final String profilePicture;

  const TeacherData({
    required this.email,
    required this.userName,
    required this.userRole,
    required this.englishFullName,
    required this.arabicFullName,
    required this.birthDate,
    required this.phoneNumber,
    required this.profilePicture,
  });

  @override
  List<Object?> get props => [
        email,
        userName,
        userRole,
        englishFullName,
        arabicFullName,
        birthDate,
        phoneNumber,
        profilePicture,
      ];
}
