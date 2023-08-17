import '../../domain/entities/class_year.dart';

class ClassYearModel extends ClassYear {
  const ClassYearModel({
    required super.englishName,
    required super.arabicName,
    required super.id,
  });

  factory ClassYearModel.fromJson(Map<String, dynamic> json) => ClassYearModel(
        englishName: json["englishName"],
        arabicName: json["arabicName"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "englishName": englishName,
        "arabicName": arabicName,
        "id": id,
      };
}
