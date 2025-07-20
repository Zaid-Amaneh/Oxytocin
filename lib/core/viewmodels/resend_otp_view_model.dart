import 'dart:async';
import 'package:flutter/foundation.dart';

class ResendOtpViewModel extends ChangeNotifier {
  static const int _startTime = 5;

  late Timer _timer;
  int _secondsLeft = _startTime;

  int get secondsLeft => _secondsLeft;

  bool get canResend => _secondsLeft == 0;

  void startTimer() {
    _secondsLeft = _startTime;
    notifyListeners();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft == 0) {
        timer.cancel();
      } else {
        _secondsLeft--;
        notifyListeners();
      }
    });
  }

  void resendOtp() {
    if (!canResend) return;
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
