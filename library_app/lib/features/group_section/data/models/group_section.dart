import '../../domain/entities/group_section.dart';

class SectionGroupModel extends SectionGroup {
  const SectionGroupModel({
    required super.sectionEnglishName,
    required super.sectionArabicName,
    required super.id,
  });

  factory SectionGroupModel.fromJson(Map<String, dynamic> json) =>
      SectionGroupModel(
        id: json["sectionID"],
        sectionEnglishName: json["sectionEnglishName"],
        sectionArabicName: json["sectionArabicName"],
      );

  Map<String, dynamic> toJson() => {
        "sectionID": id,
        "sectionEnglishName": sectionEnglishName,
        "sectionArabicName": sectionArabicName,
      };
}
