import 'package:bloc/bloc.dart';
import 'package:ebook/features/teacher_features/assignment/domain/usecases/get_assignment_by_id_usecase.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/response/assignment_details.dart';

part 'get_assignment_by_id_state.dart';

class GetAssignmentByIdCubit extends Cubit<GetAssignmentByIdState> {
  final GetAssignmentByIDUseCase getAssignmentByIDUseCase;
  GetAssignmentByIdCubit(this.getAssignmentByIDUseCase)
      : super(GetAssignmentByIdInitial());

  Future<void> getAssignmentById(String id) async {
    emit(GetAssignmentByIdLoading());
    final response = await getAssignmentByIDUseCase(p: id);
    response.fold(
      (l) => emit(GetAssignmentByIdFailed(l.message)),
      (r) => emit(GetAssignmentByIdSuccess(r)),
    );
  }
}
