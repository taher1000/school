part of 'assignment_statistics_bloc.dart';

class AssignmentStatisticsState extends Equatable {
  final RequestStatus status;
  final List<AssignmentStatistics> assignmentStatistics;
  final bool hasReachedMax;
  final String errorMessage;

  const AssignmentStatisticsState({
    this.assignmentStatistics = const [],
    this.status = RequestStatus.loading,
    this.hasReachedMax = false,
    this.errorMessage = '',
  });
  AssignmentStatisticsState copyWith({
    RequestStatus? status,
    List<AssignmentStatistics>? assignmentStatistics,
    bool? hasReachedMax,
    String? errorMessage,
    int? currentPageNumber,
  }) {
    return AssignmentStatisticsState(
      assignmentStatistics: assignmentStatistics ?? this.assignmentStatistics,
      status: status ?? this.status,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        status,
        assignmentStatistics,
        hasReachedMax,
        errorMessage,
      ];
}
