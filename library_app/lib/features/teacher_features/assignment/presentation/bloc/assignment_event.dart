part of 'assignment_bloc.dart';

abstract class AssignmentEvent extends Equatable {
  const AssignmentEvent();

  @override
  List<Object> get props => [];
}

class FetchAssignments extends AssignmentEvent {
  const FetchAssignments();
}
