part of 'delete_assignment_cubit.dart';

sealed class DeleteAssignmentState extends Equatable {
  const DeleteAssignmentState();

  @override
  List<Object> get props => [];
}

final class DeleteAssignmentInitial extends DeleteAssignmentState {}

final class DeleteAssignmentLoading extends DeleteAssignmentState {}

final class DeleteAssignmentSuccess extends DeleteAssignmentState {
  final String message;

  const DeleteAssignmentSuccess(this.message);

  @override
  List<Object> get props => [message];
}

final class DeleteAssignmentFailure extends DeleteAssignmentState {
  final String message;

  const DeleteAssignmentFailure(this.message);

  @override
  List<Object> get props => [message];
}
