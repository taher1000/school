import 'package:bloc/bloc.dart';
import 'package:ebook/injection_container.dart';
import 'package:equatable/equatable.dart';

import '../../../main/domain/entities/user_data.dart';
import '../../../main/domain/usecases/user_usecase.dart';

part 'my_profile_event.dart';
part 'my_profile_state.dart';

class MyProfileBloc extends Bloc<MyProfileEvent, MyProfileState> {
  final ProfileDataUseCase profileDataUseCase;
  MyProfileBloc(this.profileDataUseCase) : super(MyProfileInitial()) {
    on<MyProfileEvent>((event, emit) async {
      if (event is GetProfileInfoEvent) {
        emit(MyProfileLoading());
        final response = await profileDataUseCase.getUserData();

        response.fold((l) => emit(MyProfileError(l)), (r) {
          sharedPrefsClient.userImage = r.profilePicture;
          return emit(MyProfileLoaded(r));
        });
      }
    });
  }
}
