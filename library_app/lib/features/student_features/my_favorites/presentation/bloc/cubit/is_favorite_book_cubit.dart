import 'package:bloc/bloc.dart';
import '../../../domain/usecases/is_favorite_book_use_case.dart';
import 'package:equatable/equatable.dart';

part 'is_favorite_book_state.dart';

class IsFavoriteBookCubit extends Cubit<IsFavoriteBookState> {
  final IsFavoriteBookUseCase getUseCase;
  IsFavoriteBookCubit(this.getUseCase) : super(IsFavoriteBookInitial());

  Future<void> isFavoriteBook(String bookId) async {
    emit(IsFavoriteBookLoading());
    final result = await getUseCase(p: bookId);
    result.fold((l) => emit(IsFavoriteBookError(l.message)),
        (r) => emit(IsFavoriteBookLoaded(r)));
  }
}
