import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/delete_assignment_usecase.dart';

part 'delete_assignment_state.dart';

class DeleteAssignmentCubit extends Cubit<DeleteAssignmentState> {
  final DeleteAssignmentUseCase deleteAssignmentUseCase;
  DeleteAssignmentCubit(this.deleteAssignmentUseCase)
      : super(DeleteAssignmentInitial());

  Future<void> deleteAssignment(String id) async {
    emit(DeleteAssignmentLoading());
    final result = await deleteAssignmentUseCase(p: id);
    result.fold(
      (failure) => emit(DeleteAssignmentFailure(failure.message)),
      (success) => emit(DeleteAssignmentSuccess(success)),
    );
  }
}
