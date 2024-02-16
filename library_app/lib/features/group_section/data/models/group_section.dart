import '../../domain/entities/group_section.dart';

class SectionGroupModel extends SectionGroup {
  const SectionGroupModel({
    required super.sectionEnglishName,
    required super.sectionArabicName,
    required super.id,
  });

  factory SectionGroupModel.fromJson(Map<String, dynamic> json) =>
      SectionGroupModel(
        id: json["id"],
        sectionEnglishName: json["englishName"],
        sectionArabicName: json["arabicName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "englishName": sectionEnglishName,
        "arabicName": sectionArabicName,
      };
}
