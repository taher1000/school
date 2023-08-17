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
  final GetAllStudentsLoadingMore? loading;
  final GetAllStudentsLoadMoreError? error;
  const GetAllStudentsLoaded({
    required this.students,
    this.loading,
    this.error,
  });
}

// LoadingMore Model
class GetAllStudentsLoadingMore {
  final String message;
  GetAllStudentsLoadingMore({required this.message});
}

// LoadingMoreError Model
class GetAllStudentsLoadMoreError {
  final String message;
  GetAllStudentsLoadMoreError({required this.message});
}
