import 'package:bloc/bloc.dart';
import 'package:library_app/features/teacher_features/my_teacher_profile/data/models/teacher_data.dart';
import 'package:library_app/features/teacher_features/my_teacher_profile/domain/entities/teacher_data.dart';
import 'package:library_app/injection_container.dart';
import 'package:equatable/equatable.dart';

import '../../../../main/domain/usecases/user_usecase.dart';

part 'my_teacher_profile_event.dart';
part 'my_teacher_profile_state.dart';

class MyTeacherProfileBloc
    extends Bloc<MyTeacherProfileEvent, MyTeacherProfileState> {
  final ProfileDataUseCase profileDataUseCase;
  MyTeacherProfileBloc(this.profileDataUseCase)
      : super(MyTeacherProfileInitial()) {
    on<MyTeacherProfileEvent>((event, emit) async {
      if (event is GetTeacherProfileInfoEvent) {
        emit(MyTeacherProfileLoading());
        final response = await profileDataUseCase.getTeacherProfileData();

        response.fold((l) => emit(MyTeacherProfileError(l)), (r) {
          sharedPrefsClient.userImage = r.profilePicture;
          return emit(MyTeacherProfileLoaded(r));
        });
      }
    });
  }
}
