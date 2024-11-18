import 'dart:async';

import 'package:flutter/cupertino.dart';

class TimerModel with ChangeNotifier {
  int _remainingTime = 60; // 假设初始倒计时时间为60秒
  Timer? _timer;

  int get remainingTime => _remainingTime;

  void startTimer() {
    _remainingTime = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _remainingTime--;
      notifyListeners(); // 通知监听器状态已更改
      // print('当前的计时$_remainingTime');
      if (_remainingTime <= 0) {
        timer.cancel(); // 倒计时结束，取消Timer
        // _remainingTime = 60; // 可以选择重置或保持为0
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
  }
}