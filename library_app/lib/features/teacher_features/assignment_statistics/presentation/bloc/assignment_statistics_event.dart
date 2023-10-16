part of 'assignment_statistics_bloc.dart';

sealed class AssignmentStatisticsEvent extends Equatable {
  const AssignmentStatisticsEvent();

  @override
  List<Object> get props => [];
}

class FetchAssignmentStatisticsEvent extends AssignmentStatisticsEvent {
  final int? bookID;
  final int? studentID;
  const FetchAssignmentStatisticsEvent({this.studentID, this.bookID});
}
