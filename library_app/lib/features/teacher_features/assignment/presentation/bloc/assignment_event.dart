part of 'assignment_bloc.dart';

abstract class AssignmentEvent extends Equatable {
  const AssignmentEvent();

  @override
  List<Object> get props => [];
}

class FetchAssignments extends AssignmentEvent {
  final bool isRefresh;
  const FetchAssignments({this.isRefresh = false});
}
