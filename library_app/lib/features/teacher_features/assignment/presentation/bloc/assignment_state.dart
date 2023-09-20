part of 'assignment_bloc.dart';

abstract class AssignmentState extends Equatable {
  const AssignmentState();

  @override
  List<Object> get props => [];
}

class AssignmentInitial extends AssignmentState {}

class GetAssignments extends AssignmentState {}

class GetAssignmentsLoading extends AssignmentState {}

class GetAssignmentsError extends AssignmentState {
  final String message;
  const GetAssignmentsError({required this.message});
}

class GetAssignmentsEmpty extends AssignmentState {}

class GetAssignmentsLoaded extends AssignmentState {
  final TeacherAssignmentSummaryResponsePage assignments;

  const GetAssignmentsLoaded({
    required this.assignments,
  });
}
