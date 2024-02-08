import 'package:equatable/equatable.dart';

class Student extends Equatable {
  final String studentId;
  final String englishName;
  final String arabicName;
  final DateTime? academicYear;
  final DateTime? dateOfAdmission;
  final DateTime? dateOfBirth;
  final String? profilePicture;
  final String? rollNo;
  final bool isActive;
  final String? address1;
  final String? address2;
  final String? city;
  final String? state;
  final String? zipcode;
  final String? country;
  final String? parentEmail;
  final String? parentAddress1;
  final String? parentAddress2;
  final String? parentCity;
  final String? parentState;
  final String? parentZipcode;
  final String? parentCountry;
  final int sectionId;
  final String? sectionEnglishName;
  final String? sectionArabicName;
  final int classYearId;
  final String? classYearEnglishName;
  final String? classYearArabicName;
  final String? schoolId;
  final String? schoolEnglishName;
  final String? schoolArabicName;

  const Student({
    required this.studentId,
    required this.englishName,
    required this.arabicName,
    required this.academicYear,
    required this.dateOfAdmission,
    required this.dateOfBirth,
    required this.profilePicture,
    required this.rollNo,
    required this.isActive,
    required this.address1,
    required this.address2,
    required this.city,
    required this.state,
    required this.zipcode,
    required this.country,
    required this.parentEmail,
    required this.parentAddress1,
    required this.parentAddress2,
    required this.parentCity,
    required this.parentState,
    required this.parentZipcode,
    required this.parentCountry,
    required this.sectionId,
    required this.sectionEnglishName,
    required this.sectionArabicName,
    required this.classYearId,
    required this.classYearEnglishName,
    required this.classYearArabicName,
    required this.schoolId,
    required this.schoolEnglishName,
    required this.schoolArabicName,
  });

  @override
  List<Object?> get props => [
        studentId,
        englishName,
        arabicName,
        academicYear,
        dateOfAdmission,
        dateOfBirth,
        profilePicture,
        rollNo,
        isActive,
        address1,
        address2,
        city,
        state,
        zipcode,
        country,
        parentEmail,
        parentAddress1,
        parentAddress2,
        parentCity,
        parentState,
        parentZipcode,
        parentCountry,
        sectionId,
        sectionEnglishName,
        sectionArabicName,
        classYearId,
        classYearEnglishName,
        classYearArabicName,
        schoolId,
        schoolEnglishName,
        schoolArabicName,
      ];
}
