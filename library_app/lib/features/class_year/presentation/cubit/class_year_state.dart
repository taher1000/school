part of 'class_year_cubit.dart';

sealed class ClassYearState extends Equatable {
  const ClassYearState();

  @override
  List<Object> get props => [];
}

final class ClassYearInitial extends ClassYearState {}

final class FetchClassYears extends ClassYearState {}

final class GetClassYearsLoading extends ClassYearState {}

final class GetClassYearsLoaded extends ClassYearState {
  final List<ClassYear> classYears;

  const GetClassYearsLoaded(this.classYears);

  @override
  List<Object> get props => [classYears];
}

final class GetClassYearsError extends ClassYearState {
  final String message;

  const GetClassYearsError(this.message);

  @override
  List<Object> get props => [message];
}
