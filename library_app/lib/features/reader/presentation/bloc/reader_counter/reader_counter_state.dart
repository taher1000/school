part of 'reader_counter_cubit.dart';

class ReaderCounterState extends Equatable {
  int remainingTime;
  Timer timer;
  ReaderCounterState({
    required this.remainingTime,
    required this.timer,
  });

  ReaderCounterState copyWith({
    int? remainingTime,
    Timer? timer,
  }) {
    return ReaderCounterState(
      remainingTime: remainingTime ?? this.remainingTime,
      timer: timer ?? this.timer,
    );
  }

  @override
  List<Object> get props => [
        remainingTime,
        timer,
      ];
}

// class ReaderCounterInitial extends ReaderCounterState {}

class ReaderCounterStateUpdated extends ReaderCounterState {
  ReaderCounterStateUpdated({
    required int remainingTime,
    required Timer timer,
  }) : super(remainingTime: remainingTime, timer: timer);
}
