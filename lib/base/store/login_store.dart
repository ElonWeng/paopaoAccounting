import 'package:paopao_accounting/base/store/login_api.dart';
import 'package:paopao_accounting/net/dio_manger.dart';

class LoginStore{

  //登录
  static Future<Map> login(email,code) async {
    var response =await LoginApi.postLogin(email, code);
    try{
      var data = response.data;
      if(data[DioManger.code] == 200){
        return {
          DioManger.success: true,
        };
      }else{
        return {
          DioManger.success: false,
          DioManger.msg: data[DioManger.msg]
        };
      }
    }catch(e){
      return {
        DioManger.success: false,
        DioManger.msg:'登录失败!'
      };
    }
  }

  //获取邮箱验证码
  static Future<Map> sendEmailCode(email) async {
    var response = await LoginApi.getSendEmailCode(email);
    try{
      var data = response.data;
      if(data[DioManger.code] == 200){
        return {
          DioManger.success: true,
        };
      }else{
        return {
          DioManger.success: false,
          DioManger.msg: data[DioManger.msg]
        };
      }
    }catch(e){
      return {
        DioManger.success: false,
        DioManger.msg: '获取失败'
      };
    }
  }

}