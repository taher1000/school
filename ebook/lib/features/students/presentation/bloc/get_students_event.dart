part of 'get_students_bloc.dart';

sealed class GetStudentsEvent extends Equatable {
  const GetStudentsEvent();
}

class FetchStudents extends GetStudentsEvent {
  final int sectionID;
  final int classYearID;
  const FetchStudents({required this.sectionID, required this.classYearID});
  @override
  List<Object?> get props => [];
}
