part of 'classroom_bloc.dart';

abstract class ClassroomState extends Equatable {
  const ClassroomState();  

  @override
  List<Object> get props => [];
}
class ClassroomInitial extends ClassroomState {}
