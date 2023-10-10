part of 'assignment_bloc.dart';

class AssignmentState extends Equatable {
  final RequestStatus status;
  final List<TeacherAssignment> assignments;
  final bool hasReachedMax;
  final String errorMessage;

  const AssignmentState({
    this.assignments = const [],
    this.status = RequestStatus.loading,
    this.hasReachedMax = false,
    this.errorMessage = '',
  });
  AssignmentState copyWith({
    RequestStatus? status,
    List<TeacherAssignment>? assignments,
    bool? hasReachedMax,
    String? errorMessage,
    int? currentPageNumber,
  }) {
    return AssignmentState(
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
