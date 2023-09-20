import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:library_app/features/reader/domain/entities/request/book_completed_status.dart';

import '../../../domain/usecases/save_student_book_status_use_case.dart';

part 'save_student_book_status_state.dart';

class SaveStudentBookStatusCubit extends Cubit<SaveStudentBookStatusState> {
  final SaveStudentBookStatusUseCase saveStudentBookStatusUseCase;
  SaveStudentBookStatusCubit(this.saveStudentBookStatusUseCase)
      : super(SaveStudentBookStatusInitial());

  Future<void> saveStudentBookStatus(
      BookCompletedStatus completedStatus) async {
    emit(SaveStudentBookStatusLoading());
    final res = await saveStudentBookStatusUseCase(p: completedStatus);
    res.fold(
      (l) => emit(SaveStudentBookStatusFailure(l.message)),
      (r) => emit(SaveStudentBookStatusSuccess(r)),
    );
  }
}
