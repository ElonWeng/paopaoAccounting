
import 'package:flutter/material.dart';
import 'package:paopao_accounting/base/config/text_size_key.dart';


class FontSizeModel with ChangeNotifier {
  double _fontSize =  14.0; // 默认语言

  double get fontSize => _fontSize;

  set fontSize(double value) {
    if (_fontSize == value) return;
    _fontSize = value;
    notifyListeners(); 
  }

  double getTextSize(String key) {
    switch (key) {
      case TextSizeKey.logoTitleSize:
        return 25.0;
      case TextSizeKey.bigTitleSize:
        return 20.0;
      case TextSizeKey.titleSize:
        return 15.0;
      case TextSizeKey.contentSize:
        return 14.0;
      default:
        return 14.0;
    }
  }

}