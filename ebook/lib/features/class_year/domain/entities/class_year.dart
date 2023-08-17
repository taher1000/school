import 'package:equatable/equatable.dart';

class ClassYear extends Equatable {
  final String englishName;
  final String arabicName;
  final int id;

  const ClassYear({
    required this.englishName,
    required this.arabicName,
    required this.id,
  });

  @override
  List<Object?> get props => [
        englishName,
        arabicName,
        id,
      ];
}
