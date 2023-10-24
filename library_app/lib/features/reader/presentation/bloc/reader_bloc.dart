import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:library_app/features/reader/data/parameters/book_content_params.dart';
import 'package:library_app/features/reader/domain/usecases/get_book_content_use_case.dart';

import '../../../../core/enums/request_status.dart';

part 'reader_event.dart';
part 'reader_state.dart';

class ReaderBloc extends Bloc<ReaderEvent, ReaderState> {
  final GetBookContentUseCase getBookContentUseCase;
  ReaderBloc(this.getBookContentUseCase)
      : super(ReaderState(
          status: RequestStatus.loading,
          content: List.empty(growable: true),
          hasReachedMax: false,
          errorMessage: '',
        )) {
    on<ReaderEvent>((event, emit) async {
      if (event is GetBookContentEvent) {
        final response =
            await getBookContentUseCase(p: event.bookContentParams);
        if (state.status == RequestStatus.loading) {
          response.fold(
              (l) => emit(state.copyWith(
                  content: null,
                  status: RequestStatus.error,
                  hasReachedMax: false,
                  errorMessage: l.message)),
              (r) => emit(state.copyWith(
                    content: r.data,
                    status: RequestStatus.success,
                    hasReachedMax: false,
                    errorMessage: '',
                  )));
        } else {
          response.fold(
              (l) => emit(state.copyWith(
                  content: null,
                  status: RequestStatus.error,
                  hasReachedMax: false,
                  errorMessage: l.message)), (r) {
            final List<String> newContent = r.data;

            return emit(state.copyWith(
                content: List.of(state.content)..addAll(newContent),
                status: RequestStatus.success,
                hasReachedMax: false,
                errorMessage: ''));
          });
        }
      }
    });
  }
}
