import 'package:flutter/cupertino.dart';

class LoadingModel extends ChangeNotifier {
  bool isLoading = false;

  void show() {
    isLoading = true;
    notifyListeners();
  }

  void hide() {
    isLoading = false;
    notifyListeners();
  }
}