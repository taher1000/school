import 'package:bloc/bloc.dart';
import 'package:library_app/features/student_features/my_student_profile/domain/entities/student_data.dart';
import 'package:library_app/injection_container.dart';
import 'package:equatable/equatable.dart';

import '../../../../main/domain/usecases/user_usecase.dart';

part 'my_student_profile_event.dart';
part 'my_student_profile_state.dart';

class MyStudentProfileBloc
    extends Bloc<MyStudentProfileEvent, MyStudentProfileState> {
  final ProfileDataUseCase profileDataUseCase;
  MyStudentProfileBloc(this.profileDataUseCase)
      : super(MyStudentProfileInitial()) {
    on<MyStudentProfileEvent>((event, emit) async {
      if (event is GetStudentProfileInfoEvent) {
        emit(MyStudentProfileLoading());
        final response = await profileDataUseCase.getStudentProfileData();

        response.fold((l) => emit(MyStudentProfileError(l)), (r) {
          sharedPrefsClient.userImage = r.profilePicture;
          return emit(MyStudentProfileLoaded(r));
        });
      }
    });
  }
}
