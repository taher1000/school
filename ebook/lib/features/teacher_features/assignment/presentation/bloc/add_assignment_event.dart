part of 'add_assignment_bloc.dart';

sealed class AddAssignmentEvent extends Equatable {
  const AddAssignmentEvent();
  @override
  List<Object> get props => [];
}

class UpdateAssignmentInfoEvent extends AddAssignmentEvent {
  final AssignmentPostRequestBody? assignmentPostRequestBody;
  const UpdateAssignmentInfoEvent({
    this.assignmentPostRequestBody,
  });
  @override
  List<Object> get props => [];
}

class AddNewAssignmentEvent extends AddAssignmentEvent {
  final AssignmentPostRequestBody? assignmentPostRequestBody;
  const AddNewAssignmentEvent({
    this.assignmentPostRequestBody,
  });
  @override
  List<Object> get props => [];
}
