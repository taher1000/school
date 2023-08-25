part of 'my_assignments_bloc.dart';

abstract class MyAssignmentsState extends Equatable {
  const MyAssignmentsState();

  @override
  List<Object> get props => [];
}

class MyAssignmentsInitial extends MyAssignmentsState {}

class GetMyAssignments extends MyAssignmentsState {}

class GetMyAssignmentsLoading extends MyAssignmentsState {}

class GetMyAssignmentsError extends MyAssignmentsState {
  final String message;
  const GetMyAssignmentsError({required this.message});
}

class GetMyAssignmentsEmpty extends MyAssignmentsState {}

class GetMyAssignmentsLoaded extends MyAssignmentsState {
  final StudentAssignmentSummaryResponsePage assignments;
  final LoadingMore? loading;
  final LoadMoreError? error;
  const GetMyAssignmentsLoaded({
    required this.assignments,
    this.loading,
    this.error,
  });
}

// LoadingMore Model
class LoadingMore {
  final String message;
  LoadingMore({required this.message});
}

// LoadingMoreError Model
class LoadMoreError {
  final String message;
  LoadMoreError({required this.message});
}
