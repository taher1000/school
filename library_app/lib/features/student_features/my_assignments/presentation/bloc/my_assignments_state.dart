part of 'my_assignments_bloc.dart';

class MyAssignmentsState extends Equatable {
  final RequestStatus status;
  final List<StudentAssignment> assignments;
  final bool hasReachedMax;
  final String errorMessage;

  const MyAssignmentsState({
    this.assignments = const [],
    this.status = RequestStatus.loading,
    this.hasReachedMax = false,
    this.errorMessage = '',
  });
  MyAssignmentsState copyWith({
    RequestStatus? status,
    List<StudentAssignment>? books,
    bool? hasReachedMax,
    String? errorMessage,
    int? currentPageNumber,
  }) {
    return MyAssignmentsState(
      assignments: books ?? this.assignments,
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
