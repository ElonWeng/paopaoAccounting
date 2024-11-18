
import 'package:flutter/foundation.dart';
import 'package:paopao_accounting/base/util/shared_preferences_util.dart';

class Configs{
  static String key_host_port = 'HostAndPort';//域名的保存持久化
  static String key_global = 'key_global';//本地语言的持久化

  static String _host = 'http://34.27.187.159';
  static String _port = '8092';
  static String _language = 'en';

  static String get host => _host;

  static set host(String newHost) {
    _host = newHost;
  }

  static String get port => _port;

  static set port(String newPort) {
    _port = newPort;
  }

  static String get language => _language;

  static set language(String newLanguage) {
    _language = newLanguage;
  }


  static init() async {
    String? valueHostPort =await SharedPreferencesUtil.getString(Configs.key_host_port);
    print('当前的域名$valueHostPort');
    if(valueHostPort == null){
      Configs.host = _host;
      Configs.port = _port;
    }else{
      try{
        var splitValue = valueHostPort.toString().split(',');
        Configs.host = splitValue[0];
        Configs.port = splitValue[1];
      }catch(e){
        if (kDebugMode) {
          print('接口初始化异常');
        }
      }
    }
    //获取上次保存的本地语言
    String? valueLanguage =await SharedPreferencesUtil.getString(Configs.key_global);
    print('当前的语言 $valueLanguage');
    if(valueHostPort == null){
      Configs.language = _language;
    }else{
      try{
        Configs.language = valueLanguage.toString();
      }catch(e){
        if (kDebugMode) {
          print('语言初始化异常');
        }
      }
    }

  }



}