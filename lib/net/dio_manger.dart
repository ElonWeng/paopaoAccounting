import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:paopao_accounting/base/config/configs.dart';
import 'package:paopao_accounting/base/util/log_util.dart';

import '../base/util/check_util.dart';

class DioManger {
  static String success = 'success';
  static String msg = 'msg';
  static String code = 'code';
  static int connectTime = 10;
  static String errMsg = '服务异常';
  static String tokenErrMsg = '登录已过期，请重新登录～';
  static String serverErrMsg = '服务异常';
  static String head = '123';

  /// global dio object
  static Dio? dio;

  static var options;

  /// http request methods
  static const String GET = 'get';
  static const String POST = 'post';
  static const String upPOST = 'upPOST';
  static const String OAUTH = 'oauth';
  static const String PATCH = 'patch';
  static const String DELETE = 'delete';
  static const String PUT = 'put';
  static const String DELETE_BODY = 'deleteBody';

  /// 创建 dio 实例对象
  static Dio? createInstance(header) {
    options = BaseOptions(
        connectTimeout: Duration(seconds: connectTime),
        receiveTimeout: Duration(seconds: connectTime),
        responseType: ResponseType.json,
        validateStatus: (status) {
          return true;
        },
        // host: host,
        // headers: header
    );
    dio = Dio(options);
    return dio;
  }

  static void add(Dio dio) {
    dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options,
        RequestInterceptorHandler requestInterceptorHandler) {
      print(
          "\n================================= 请求数据 =================================");
      print("method = ${options.method.toString()}");
      print("url = ${options.uri.toString()}");
      print("headers = ${options.headers}");
      print("queryParameters = ${options.queryParameters.toString()}");
      print("data = ${options.data.toString()}");
      print(
          "================================= 请求数据结束 =================================\n");
    }, onResponse: (Response response,
        ResponseInterceptorHandler responseInterceptorHandler) {
      print(
          "\n================================= 响应数据开始 =================================");
      print("code = ${response.statusCode}");
      print("data = ${response.data}");
      print(
          "================================= 响应数据结束 =================================\n");
    }, onError: (DioError e, ErrorInterceptorHandler errorInterceptorHandler) {
      print(
          "\n=================================错误响应数据 =================================");
      print("type = ${e.type}");
      print("message = ${e.message}");
      print("stackTrace = ${e.stackTrace}");
      print("\n");
    }));
    print('结束-----------------');
  }

  /// 清空 dio 对象
  static clear() {
    dio = null;
  }

  static Future<Response> get(
    String url, {
    header,
    FormData? formData,
  }) async {
    try {
      Response response;
      Dio? dio = createInstance(header);
      if (!CheckUtil.isRelease()) {
        LogUtil.debug('get请求头部', header.toString());
        LogUtil.debug('get请求地址', url.toString());
        LogUtil.debug('get请求参数', formData.toString());
      }
      if (formData != null) {
        response = await dio!
            .get(url, queryParameters: Map.fromEntries(formData.fields));
      } else {
        response = await dio!.get(url);
      }
      LogUtil.debug('get请求返回 ',url+ response.toString() + '     ' + response.statusCode.toString());
      return response;
    } catch (e) {
      LogUtil.debug('-------------get请求出错-------------', e.toString());
      return Response(
          requestOptions: RequestOptions(path: url),
          statusCode: 500,
          data: {'success': false, 'msg': errMsg});
    }
  }

  ///Post请求 application/json     JSON数据格式
  static Future<Response> post(
    String url, {
    header,
    paramMap,
  }) async {
    try {
      Response response;
      Dio? dio = createInstance(header);
      if (!CheckUtil.isRelease()) {
        LogUtil.debug('post请求头部', header.toString());
        LogUtil.debug('post请求地址', url.toString());
        LogUtil.debug('post请求参数', paramMap.toString());
      }
      if (paramMap != null) {
        response = await dio!.post(url, data: paramMap);
      } else {
        response = await dio!.post(url);
      }
      LogUtil.debug('post请求返回 ', url+ response.toString() + '     ' + response.statusCode.toString());
      return response;
    } catch (e) {
      LogUtil.debug('-------------post请求出错-------------', e.toString());
      return Response(
          requestOptions: RequestOptions(path: url),
          statusCode: 500,
          data: {'success': false, 'msg': errMsg});
    }
  }

  static Future<Response> upPost(
    String url, {
    header,
    formData,
  }) async {
    try {
      Response response;
      Dio? dio = createInstance(header);
      if (!CheckUtil.isRelease()) {
        LogUtil.debug('upPost请求头部', header.toString());
        LogUtil.debug('upPost请求地址', url.toString());
        LogUtil.debug('upPost请求参数', formData.toString());
      }
      if (formData != null) {
        response = await dio!.post(url, data: formData,
            onSendProgress: (int progress, int total) {
          print("当前进度是 $progress 总进度是 $total");
        });
      } else {
        response = await dio!.post(url);
      }
      LogUtil.debug('upPost', response.toString());
      return response;
    } catch (e) {
      LogUtil.debug('-------------upPost请求出错-------------', e.toString());
      // return json.decode({"success": false, "errMsg": "响应超时"}.toString());
      return Response(
          requestOptions: RequestOptions(path: url),
          statusCode: 500,
          data: {'success': false, 'msg': errMsg});
      return json.decode(e.toString());
    }
  }

  static Future<Response> oauth<T>(
    String url, {
    header,
    FormData? formData,
  }) async {
    try {
      Response response;
      Dio? dio = createInstance(header);
      // print('oauth请求地址：' + url);
      // print('oauth请求参数：' + formData.toString());
      if (!CheckUtil.isRelease()) {
        LogUtil.debug('oauth请求头部', header.toString());
        LogUtil.debug('oauth请求地址', url.toString());
        LogUtil.debug('oauth请求参数', formData.toString());
      }
      if (formData != null) {
        response = await dio!.post(url, data: formData);
      } else {
        response = await dio!.post(url);
      }
      LogUtil.debug('oauth', response.toString());
      return response;
    } catch (e) {
      LogUtil.debug('-------------oauth请求出错-------------', e.toString());
      return Response(
          requestOptions: RequestOptions(path: url),
          statusCode: 500,
          data: {'success': false, 'msg': errMsg});
    }
  }

  static Future<Response> delete(
    String url, {
    header,
    FormData? formData,
  }) async {
    try {
      Response response;
      Dio? dio = createInstance(header);
      // print('delete请求头部：' + header.toString());
      // print('delete请求地址：' + url);
      // print('delete请求参数：' + formData.toString());
      if (formData != null) {
        response = await dio!
            .delete(url, queryParameters: Map.fromEntries(formData.fields));
      } else {
        response = await dio!.delete(url);
      }
      // LogUtil.debug('delete：', response.toString());
      return response;
    } catch (e) {
      LogUtil.debug('-------------delete请求出错-------------', e.toString());
      return Response(
          requestOptions: RequestOptions(path: url),
          statusCode: 500,
          data: {'success': false, 'msg': errMsg});
    }
  }

  static Future<Response> deleteBody(
    String url, {
    header,
    Object? formData,
  }) async {
    try {
      Response response;
      Dio? dio = createInstance(header);
      // print('delete请求头部：' + header.toString());
      // print('delete请求地址：' + url);
      // print('delete请求参数：' + formData.toString());
      if (formData != null) {
        response = await dio!.delete(url, data: formData);
      } else {
        response = await dio!.delete(url);
      }
      // LogUtil.debug('delete：', response.toString());
      return response;
    } catch (e) {
      LogUtil.debug('-------------delete请求出错-------------', e.toString());
      return Response(
          requestOptions: RequestOptions(path: url),
          statusCode: 500,
          data: {'success': false, 'msg': errMsg});
    }
  }

  static Future<Response> put(
    String url, {
    header,
    formData,
  }) async {
    try {
      Response response;
      Dio? dio = createInstance(header);
      // print('put请求头部：' + header.toString());
      // print('put请求地址：' + url);
      if (!CheckUtil.isRelease()) {
        LogUtil.debug('put请求地址', url);
        LogUtil.debug('put请求参数', formData.toString());
      }

      if (formData != null) {
        response = await dio!.put(url, data: formData);
      } else {
        response = await dio!.put(url);
      }
      // LogUtil.debug('put：', response.toString());
      return response;
    } catch (e) {
      LogUtil.debug('-------------put请求出错-------------', e.toString());
      return Response(
          requestOptions: RequestOptions(path: url),
          statusCode: 500,
          data: {'success': false, 'msg': errMsg});
    }
  }

  static Future<Response> request(
    String url, {
    paramGet,
    paramPost,
    paramOauth,
    paramDelete,
    paramDeleteBody,
    paramPut,
    paramUpPost,
    method,
  }) async {
    Response response;
    if (method == DioManger.GET) {
      response = await get(
        "${Configs.host}:${Configs.port}$url",
        formData: paramGet,
        header: head,
      );
    } else if (method == DioManger.POST) {
      response = await post(
        "${Configs.host}:${Configs.port}$url",
        paramMap: paramPost,
        header: head,
      );
    } else if (method == DioManger.upPOST) {
      response = await upPost(
        "${Configs.host}:${Configs.port}$url",
        formData: paramUpPost,
        header: head,
      );
    } else if (method == DioManger.OAUTH) {
      response = await oauth(
        "${Configs.host}:${Configs.port}$url",
        formData: paramOauth,
        header: head,
      );
    } else if (method == DioManger.DELETE) {
      response = await delete(
        "${Configs.host}:${Configs.port}$url",
        formData: paramDelete,
        header: head,
      );
    } else if (method == DioManger.DELETE_BODY) {
      response = await deleteBody(
        "${Configs.host}:${Configs.port}$url",
        formData: paramDeleteBody,
        header: head,
      );
    } else if (method == DioManger.PUT) {
      response = await put(
        "${Configs.host}:${Configs.port}$url",
        formData: paramPut,
        header: head,
      );
    } else {
      response = await get(
        url,
        formData: paramGet,
        header: head,
      );
    }
    print('当前返回数据'+response.toString());
    //部分接口数据有问题
    if (response.toString() == '') {
      return Response(
          requestOptions: RequestOptions(path: url),
          data: {'success': false, 'msg': serverErrMsg});
    } else {
      LogUtil.debug('返回的状态码', response.statusCode.toString());
      if (response.statusCode == 401) {
        return Response(
            requestOptions: RequestOptions(path: url),
            data: {'success': false, 'msg': tokenErrMsg});
      }
    }
    return response;
  }

 
}
