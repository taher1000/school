import 'dart:async';

class ReaderHandler {
  ReaderHandler._();

  static final ReaderHandler _instance = ReaderHandler._();

  factory ReaderHandler() => _instance;

  late int remainingTime;
  late Timer _timer;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        remainingTime--;
      } else {
        _timer.cancel();
      }
    });
  }
}
