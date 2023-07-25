part of 'assignment_bloc.dart';

abstract class AssignmentState extends Equatable {
  const AssignmentState();  

  @override
  List<Object> get props => [];
}
class AssignmentInitial extends AssignmentState {}
