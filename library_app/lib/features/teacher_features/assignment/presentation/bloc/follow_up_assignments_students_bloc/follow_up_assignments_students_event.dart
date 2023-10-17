part of 'follow_up_assignments_students_bloc.dart';

sealed class FollowUpAssignmentsStudentsEvent extends Equatable {
  const FollowUpAssignmentsStudentsEvent();

  @override
  List<Object> get props => [];
}

class FetchFollowUpAssignments extends FollowUpAssignmentsStudentsEvent {
  final bool isRefresh;

  const FetchFollowUpAssignments({this.isRefresh = false});
}
