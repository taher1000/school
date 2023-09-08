import 'package:bloc/bloc.dart';
import '../../domain/usecases/get_class_year_usecase.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/class_year.dart';

part 'class_year_state.dart';

class ClassYearCubit extends Cubit<ClassYearState> {
  final GetClassYearsUseCase getClassYearsUseCase;
  ClassYearCubit(this.getClassYearsUseCase) : super(ClassYearInitial());

  Future<void> getClassYears() async {
    emit(GetClassYearsLoading());
    final result = await getClassYearsUseCase.call();
    result.fold(
      (l) => emit(GetClassYearsError(l.message)),
      (r) => emit(GetClassYearsLoaded(r)),
    );
  }
}
