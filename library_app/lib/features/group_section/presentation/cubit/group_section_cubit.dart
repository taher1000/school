import 'package:bloc/bloc.dart';
import '../../domain/usecases/get_group_section_usecase.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/group_section.dart';

part 'group_section_state.dart';

class SectionGroupCubit extends Cubit<SectionGroupState> {
  final GetSectionGroupsUseCase getSectionGroupsUseCase;
  SectionGroupCubit(this.getSectionGroupsUseCase)
      : super(SectionGroupInitial());

  Future<void> getSectionGroups(int classYear) async {
    emit(GetSectionGroupsLoading());
    final result = await getSectionGroupsUseCase(p: classYear);
    result.fold(
      (l) => emit(GetSectionGroupsError(l.message)),
      (r) => emit(GetSectionGroupsLoaded(r)),
    );
  }
}
