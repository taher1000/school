import 'package:equatable/equatable.dart';

class SectionGroup extends Equatable {
  final int id;
  final String sectionEnglishName;
  final String sectionArabicName;

  const SectionGroup({
    required this.id,
    required this.sectionEnglishName,
    required this.sectionArabicName,
  });
  @override
  List<Object?> get props => [
        id,
        sectionEnglishName,
        sectionArabicName,
      ];
}
