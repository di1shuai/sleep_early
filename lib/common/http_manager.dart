import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sleep_early/common/api_url.dart';
import 'package:sleep_early/common/global.dart';
import 'package:sleep_early/models/api_response.dart';

class HttpManager {
  static HttpManager _instance;
  //需要抓包的话请打开
  static bool isProxy = false;
  Dio dio;

  static HttpManager getInstance() {
    if (_instance == null) {
      _instance = HttpManager();
    }
    return _instance;
  }

  HttpManager() {
    BaseOptions options = new BaseOptions(
      //请求基地址,可以包含子路径
      baseUrl: APIUrl.BASE_URL,
      //连接服务器超时时间，单位是毫秒.
      connectTimeout: 10000,
      //响应流上前后两次接受到数据的间隔，单位为毫秒。
      receiveTimeout: 5000,
      //Http请求头.
      headers: {
        'accept-language': 'zh-cn',
        //do something
        // "version": "1.0.0"
      },
      //请求的Content-Type，默认值是"application/json; charset=utf-8",Headers.formUrlEncodedContentType会自动编码请求体.
      contentType: Headers.jsonContentType,
      //表示期望以那种格式(方式)接受响应数据。接受4种类型 `json`, `stream`, `plain`, `bytes`. 默认值是 `json`,
      responseType: ResponseType.json,
    );
    dio = new Dio(options);
    // dio.interceptors.add(CommonInterceptor());
    dio.interceptors.add(LogInterceptor(responseBody: true));
  }


  static void _proxy() {
    (getInstance().dio.httpClientAdapter as DefaultHttpClientAdapter)
        .onHttpClientCreate = (HttpClient client) {
      client.findProxy = (uri) {
        return "PROXY 192.168.72.91:8888";
      };
    };
  }

  static _process(String url, Map<String, dynamic> params, String method) async {
    print('-------  url : $url  -------');
    if (isProxy) {
      _proxy();
    }
    try {
      Response response;
      switch (method) {
        case "GET":
          response = await getInstance().dio.get(url, queryParameters: params);
          break;
        case "POST":
          response = await getInstance().dio.post(url, data: params);
          break;
        case "PUT":
          response = await getInstance().dio.put(url, data: params);
          break;
        case "DELETE":
          response = await getInstance().dio.delete(url);
          break;
        default:
          throw Exception("不支持的请求方式");
      }

      if (response.statusCode == 200) {
        APIResponse apiResponse = APIResponse.fromMap(response.data);
        if (apiResponse.code == 0) {
          return apiResponse.data;
        } else if (apiResponse.code == 1) {
          EasyLoading.showError(apiResponse.error.message,
              duration: Duration(seconds: Global.showDialogTime));
          throw Exception(apiResponse.error.message);
        }
      }
      EasyLoading.showError("系统错误",
          duration: Duration(seconds: Global.showDialogTime));
      throw Exception("server error");
    } on DioError catch (e) {
      EasyLoading.showError(e.error,
          duration: Duration(seconds: Global.showDialogTime));
      throw e;
    }
  }

  static Future get(String url, [Map<String, dynamic> params]) async {
    return await _process(url, params, "GET");
  }

  static Future post(String url, [Map<String, dynamic> params]) async {
    return _process(url, params, "POST");
  }

  static Future put(String url, [Map<String, dynamic> params]) async {
    return _process(url, params, "PUT");
  }

  static Future delete(String url) async {
    return _process(url, null, "DELETE");
  }
}
