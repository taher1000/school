part of 'add_assignment_bloc.dart';

class AddAssignmentState extends Equatable {
  AssignmentPostRequestBody assignmentPostRequestBody;
  AddAssignmentState(
      {this.assignmentPostRequestBody = const AssignmentPostRequestBody()});

  AddAssignmentState copyWith({
    AssignmentPostRequestBody? assignmentPostRequestBody,
  }) {
    return AddAssignmentState(
      assignmentPostRequestBody:
          assignmentPostRequestBody ?? this.assignmentPostRequestBody,
    );
  }

  @override
  List<Object> get props => [];
}

final class AddNewAssignmentInitial extends AddAssignmentState {}

final class AddNewAssignmentLoading extends AddAssignmentState {}

final class AddNewAssignmentSuccess extends AddAssignmentState {
  final String message;
  AddNewAssignmentSuccess(this.message);
}

final class AddNewAssignmentFailed extends AddAssignmentState {
  final String message;
  AddNewAssignmentFailed(this.message);
}
