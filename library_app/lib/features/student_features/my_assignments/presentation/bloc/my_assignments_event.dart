part of 'my_assignments_bloc.dart';

abstract class MyAssignmentsEvent extends Equatable {
  const MyAssignmentsEvent();

  @override
  List<Object> get props => [];
}

class FetchMyAssignments extends MyAssignmentsEvent {
  final bool isRefresh;
  const FetchMyAssignments({this.isRefresh = false});
}
