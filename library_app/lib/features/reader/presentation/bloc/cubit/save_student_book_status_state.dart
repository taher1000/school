part of 'save_student_book_status_cubit.dart';

sealed class SaveStudentBookStatusState extends Equatable {
  const SaveStudentBookStatusState();

  @override
  List<Object> get props => [];
}

final class SaveStudentBookStatusInitial extends SaveStudentBookStatusState {}

final class SaveStudentBookStatusLoading extends SaveStudentBookStatusState {}

final class SaveStudentBookStatusSuccess extends SaveStudentBookStatusState {
  final String message;
  const SaveStudentBookStatusSuccess(this.message);
}

final class SaveStudentBookStatusFailure extends SaveStudentBookStatusState {
  final String message;
  const SaveStudentBookStatusFailure(this.message);
}
