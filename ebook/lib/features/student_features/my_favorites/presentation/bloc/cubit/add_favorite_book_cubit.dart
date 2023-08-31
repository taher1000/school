import 'package:bloc/bloc.dart';
import 'package:ebook/features/student_features/my_favorites/domain/usecases/add_favorite_book_use_case.dart';
import 'package:equatable/equatable.dart';

part 'add_favorite_book_state.dart';

class AddFavoriteBookCubit extends Cubit<AddFavoriteBookState> {
  final AddMyFavoriteBookUseCase addUseCase;
  AddFavoriteBookCubit(this.addUseCase) : super(AddFavoriteBookInitial());

  Future<void> addFavoriteBook(String bookId) async {
    emit(AddFavoriteBookLoading());
    final result = await addUseCase.call(p: bookId);
    result.fold((l) => emit(AddFavoriteBookError(message: l.message)),
        (r) => emit(AddFavoriteBookSuccess(message: r)));
  }
}
