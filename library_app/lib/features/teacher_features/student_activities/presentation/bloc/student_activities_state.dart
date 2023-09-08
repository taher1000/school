part of 'student_activities_bloc.dart';

abstract class StudentActivitiesState extends Equatable {
  const StudentActivitiesState();  

  @override
  List<Object> get props => [];
}
class StudentActivitiesInitial extends StudentActivitiesState {}
