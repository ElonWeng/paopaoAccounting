
import 'package:flutter/foundation.dart';
import 'package:paopao_accounting/base/util/check_util.dart';

class LoginModel extends ChangeNotifier{
  String _text = 'Google';

  String getText() {
    return _text;
  }


  void setText(String text) {
    _text = text;
    // 当数据发生变化时，通知所有监听者
    notifyListeners();
  }
  //检查邮箱合法性
   bool checkEmail(String email){
    if(CheckUtil.isValidEmail(email)){
      return true;
    }else{
      return false;
    }
  }


}