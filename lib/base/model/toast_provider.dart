import 'package:flutter/material.dart';

class ToastProvider with ChangeNotifier {
  String _message = '';
  bool _isVisible = false;

  String get message => _message;
  bool get isVisible => _isVisible;

  void showToast(String message) {
    _message = message;
    _isVisible = true;
    notifyListeners();

    // 延迟隐藏Toast
    Future.delayed(const Duration(seconds: 2), () {
      _isVisible = false;
      notifyListeners();
    });
  }
}