import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'reader_counter_state.dart';

class ReaderCounterCubit extends Cubit<ReaderCounterState> {
  ReaderCounterCubit()
      : super(ReaderCounterState(
            remainingTime: 0, timer: Timer(Duration.zero, () {})));
  void startTimer(int pagesCount) {
    state.timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.remainingTime > 0) {
        state.remainingTime--;
      } else {
        state.timer.cancel();
        // BlocProvider.of<SaveStudentBookStatusCubit>(context)
        //     .saveStudentBookStatus(BookCompletedStatus(
        //         bookId: widget.bookId,
        //         hasReadingCompleted: true,
        //         hasListeningCompleted: false));
        // Navigator.pop(context);
      }
      emit(state.copyWith(
          remainingTime: secondsCalc(pagesCount), timer: state.timer));
      emit(ReaderCounterStateUpdated(
          remainingTime: secondsCalc(pagesCount), timer: state.timer));
    });
  }

  int secondsCalc(int pagesCount) {
    return pagesCount * 120;
  }
}
