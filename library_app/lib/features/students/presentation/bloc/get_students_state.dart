part of 'get_students_bloc.dart';

sealed class GetStudentsState extends Equatable {
  const GetStudentsState();

  @override
  List<Object> get props => [];
}

final class GetAllStudentsInitial extends GetStudentsState {}

class GetAllStudentsLoading extends GetStudentsState {}

class GetAllStudentsError extends GetStudentsState {
  final String message;
  const GetAllStudentsError({required this.message});
}

class GetAllStudentsEmpty extends GetStudentsState {}

class GetAllStudentsLoaded extends GetStudentsState {
  final AllStudentsSummaryResponsePage students;

  const GetAllStudentsLoaded({
    required this.students,
  });
}
