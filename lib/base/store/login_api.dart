import 'package:dio/dio.dart';
import 'package:paopao_accounting/base/store/api.dart';
import 'package:paopao_accounting/net/dio_manger.dart';

class LoginApi {
  //登录
  static Future<Response> postLogin(email, code) {
    var request = DioManger.request(LoginUrl.login_url,
        paramPost: {
          'email': email,
          'code': code,
        },
        method: DioManger.POST);
    return request;
  }


  //获取邮箱验证码
  static Future<Response> getSendEmailCode(email) {
    var request = DioManger.request(LoginUrl.send_email_code_url,
        paramPost: {
          'email': email,
        },
        method: DioManger.POST);
    return request;
  }

}
