import 'package:bloc/bloc.dart';
import 'package:ebook/features/teacher_features/assignment/domain/usecases/add_new_assignment_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../domain/entities/request/assignment_post_request.dart';

part 'add_assignment_event.dart';
part 'add_assignment_state.dart';

class AddAssignmentBloc extends Bloc<AddAssignmentEvent, AddAssignmentState> {
  final AddNewAssignmentUseCase addNewAssignmentUseCase;
  AddAssignmentBloc(this.addNewAssignmentUseCase)
      : super(AddNewAssignmentInitial()) {
    on<AddAssignmentEvent>((event, emit) async {
      if (event is UpdateAssignmentInfoEvent) {
        emit(state.copyWith(
            assignmentPostRequestBody: AssignmentPostRequestBody(
          studentList: event.assignmentPostRequestBody!.studentList ??
              state.assignmentPostRequestBody.studentList,
          bookCollection: event.assignmentPostRequestBody!.bookCollection ??
              state.assignmentPostRequestBody.bookCollection,
          arabicName: event.assignmentPostRequestBody!.arabicName ??
              state.assignmentPostRequestBody.arabicName,
          englishName: event.assignmentPostRequestBody!.englishName ??
              state.assignmentPostRequestBody.englishName,
          startDate: event.assignmentPostRequestBody!.startDate ??
              state.assignmentPostRequestBody.startDate,
          endDate: event.assignmentPostRequestBody!.endDate ??
              state.assignmentPostRequestBody.endDate,
        )));
      }
      if (event is AddNewAssignmentEvent) {
        final assignmentPostRequestBody = AssignmentPostRequestBody(
          studentList: event.assignmentPostRequestBody!.studentList ??
              state.assignmentPostRequestBody.studentList,
          bookCollection: event.assignmentPostRequestBody!.bookCollection ??
              state.assignmentPostRequestBody.bookCollection,
          arabicName: event.assignmentPostRequestBody!.arabicName ??
              state.assignmentPostRequestBody.arabicName,
          englishName: event.assignmentPostRequestBody!.englishName ??
              state.assignmentPostRequestBody.englishName,
          startDate: event.assignmentPostRequestBody!.startDate ??
              state.assignmentPostRequestBody.startDate,
          endDate: event.assignmentPostRequestBody!.endDate ??
              state.assignmentPostRequestBody.endDate,
        );
        final response =
            await addNewAssignmentUseCase(p: assignmentPostRequestBody);

        response.fold(
            (l) => {
                  emit(AddNewAssignmentFailed(l.message)),
                  Fluttertoast.showToast(
                      msg: l.message.split('[').last.split(']').first,
                      timeInSecForIosWeb: 4),
                },
            (r) => {
                  emit(AddNewAssignmentSuccess(r)),

                  // currentContext!.read<StepperBloc>().add(IncreaseStepperEvent()),
                });
      }
    });
  }
}
