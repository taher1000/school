import 'package:equatable/equatable.dart';

class StudentData extends Equatable {
  final String studentId;
  final String englishName;
  final String arabicName;
  final dynamic academicYear;
  final dynamic dateOfAdmission;
  final DateTime dateOfBirth;
  final dynamic profilePicture;
  final String studentAvailableReadingLevel;
  final String studentCurrentReadingLevel;
  final String rollNo;
  final bool isActive;
  final dynamic address1;
  final dynamic address2;
  final dynamic city;
  final dynamic state;
  final dynamic zipcode;
  final String country;
  final dynamic parentEmail;
  final dynamic parentAddress1;
  final dynamic parentAddress2;
  final dynamic parentCity;
  final dynamic parentState;
  final dynamic parentZipcode;
  final String parentCountry;
  final int sectionId;
  final String sectionEnglishName;
  final String sectionArabicName;
  final int classYearId;
  final String classYearEnglishName;
  final String classYearArabicName;
  final String schoolId;
  final String schoolEnglishName;
  final String schoolArabicName;

  const StudentData({
    required this.studentId,
    required this.englishName,
    required this.arabicName,
    required this.academicYear,
    required this.dateOfAdmission,
    required this.dateOfBirth,
    required this.profilePicture,
    required this.studentAvailableReadingLevel,
    required this.studentCurrentReadingLevel,
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
        studentAvailableReadingLevel,
        studentCurrentReadingLevel,
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
