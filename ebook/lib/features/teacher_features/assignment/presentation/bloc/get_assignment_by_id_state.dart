part of 'get_assignment_by_id_cubit.dart';

sealed class GetAssignmentByIdState extends Equatable {
  const GetAssignmentByIdState();

  @override
  List<Object> get props => [];
}

final class GetAssignmentByIdInitial extends GetAssignmentByIdState {}

final class GetAssignmentByIdLoading extends GetAssignmentByIdState {}

final class GetAssignmentByIdSuccess extends GetAssignmentByIdState {
  final AssignmentDetails assignment;

  const GetAssignmentByIdSuccess(this.assignment);

  @override
  List<Object> get props => [assignment];
}

final class GetAssignmentByIdFailed extends GetAssignmentByIdState {
  final String message;

  const GetAssignmentByIdFailed(this.message);

  @override
  List<Object> get props => [message];
}
