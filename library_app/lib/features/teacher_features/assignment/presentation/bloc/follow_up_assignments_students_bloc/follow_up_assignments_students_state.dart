part of 'follow_up_assignments_students_bloc.dart';

sealed class FollowUpAssignmentsStudentsState extends Equatable {
  const FollowUpAssignmentsStudentsState();

  @override
  List<Object> get props => [];
}

final class FollowUpAssignmentsStudentsInitial
    extends FollowUpAssignmentsStudentsState {}

class GetFollowUpAssignments extends FollowUpAssignmentsStudentsState {}

class GetFollowUpAssignmentsLoading extends FollowUpAssignmentsStudentsState {}

class GetFollowUpAssignmentsError extends FollowUpAssignmentsStudentsState {
  final String message;
  const GetFollowUpAssignmentsError({required this.message});
}

class GetFollowUpAssignmentsEmpty extends FollowUpAssignmentsStudentsState {}

class GetFollowUpAssignmentsLoaded extends FollowUpAssignmentsStudentsState {
  final FollowUpAssignmentSummaryResponsePage followUpAssignments;

  const GetFollowUpAssignmentsLoaded({
    required this.followUpAssignments,
  });
}
