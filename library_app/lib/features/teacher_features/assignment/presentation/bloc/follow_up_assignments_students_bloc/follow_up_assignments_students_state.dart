part of 'follow_up_assignments_students_bloc.dart';

class FollowUpAssignmentsStudentsState extends Equatable {
  final RequestStatus status;
  final List<FollowUpStudent> assignments;
  final bool hasReachedMax;
  final String errorMessage;

  const FollowUpAssignmentsStudentsState({
    this.assignments = const [],
    this.status = RequestStatus.loading,
    this.hasReachedMax = false,
    this.errorMessage = '',
  });
  FollowUpAssignmentsStudentsState copyWith({
    RequestStatus? status,
    List<FollowUpStudent>? assignments,
    bool? hasReachedMax,
    String? errorMessage,
    int? currentPageNumber,
  }) {
    return FollowUpAssignmentsStudentsState(
      assignments: assignments ?? this.assignments,
      status: status ?? this.status,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        status,
        assignments,
        hasReachedMax,
        errorMessage,
      ];
}
