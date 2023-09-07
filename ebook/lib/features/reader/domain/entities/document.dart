import 'package:equatable/equatable.dart';

class DocumentBook extends Equatable {
  final String filePath;
  const DocumentBook({required this.filePath});
  @override
  List<Object?> get props => [filePath];
}
