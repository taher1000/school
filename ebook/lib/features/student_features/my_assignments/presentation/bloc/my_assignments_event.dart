part of 'my_assignments_bloc.dart';

abstract class MyAssignmentsEvent extends Equatable {
  const MyAssignmentsEvent();

  @override
  List<Object> get props => [];
}

class FetchMyAssignments extends MyAssignmentsEvent {}
