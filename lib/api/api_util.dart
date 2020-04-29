import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sleep_early/common/api_url.dart';
import 'package:sleep_early/common/global.dart';
import 'package:sleep_early/models/api_response.dart';

Map<String, dynamic> optHeader = {
  'accept-language': 'zh-cn',
  'content-type': 'application/json;charset=utf-8',
};

BaseOptions baseOptions = BaseOptions(
    connectTimeout: 30000, headers: optHeader, baseUrl: APIUrl.BASE_URL);

//需要抓包的话请打开
bool isProxy = false;

var dio = new Dio(baseOptions);

class APIUtil {
  static void _proxy() {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.findProxy = (uri) {
        return "PROXY 192.168.72.91:8888";
      };
    };
  }

  static Future get(String url, [Map<String, dynamic> params]) async {
    print('-------  url : $url  -------');
    Response response;
    APIResponse apiResponse;
    if (isProxy) {
      _proxy();
    }
    if (params != null) {
      response = await dio.get(url, queryParameters: params);
    } else {
      response = await dio.get(url);
    }
    if (response.statusCode == 200) {
      apiResponse = APIResponse.fromMap(response.data);
      if (apiResponse.code == 0) {
        return apiResponse.data;
      } else if (apiResponse.code == 1) {
        EasyLoading.showError(apiResponse.error.message,duration: Duration(seconds: Global.showDialogTime));
      }
    } else {
      print(response.data.toString());
    }
    return apiResponse.data;
  }

  static Future post(String url, [Map<String, dynamic> params]) async {
    Response response;
    APIResponse apiResponse;
    if (isProxy) {
      _proxy();
    }

    response = await dio.post(url, data: params);
    if (response.statusCode == 200) {
      apiResponse = APIResponse.fromMap(response.data);
      if (apiResponse.code == 0) {
        return apiResponse.data;
      } else if (apiResponse.code == 1) {
        EasyLoading.showError(apiResponse.error.message,duration: Duration(seconds: Global.showDialogTime));
        return apiResponse.data;
      }
    }
    return apiResponse.data;
  }

  static Future put(String url, [Map<String, dynamic> params]) async {
    Response response;
    APIResponse apiResponse;

    if (isProxy) {
      _proxy();
    }

    response = await dio.put(url, data: params);
    if (response.statusCode == 200) {
      apiResponse = APIResponse.fromMap(response.data);
      if (apiResponse.code == 0) {
        return apiResponse.data;
      } else if (apiResponse.code == 1) {
        EasyLoading.showError(apiResponse.error.message,duration: Duration(seconds: Global.showDialogTime));
        return apiResponse.data;
      }
    }
    return apiResponse.data;
  }

  static Future delete(String url) async {
    Response response;
    APIResponse apiResponse;

    if (isProxy) {
      _proxy();
    }

    response = await dio.delete(url);
    if (response.statusCode == 200) {
      apiResponse = APIResponse.fromMap(response.data);
      if (apiResponse.code == 0) {
        return apiResponse.data;
      } else if (apiResponse.code == 1) {
        EasyLoading.showError(apiResponse.error.message,duration: Duration(seconds: Global.showDialogTime));
        return null;
      }
    }
    return apiResponse.data;
  }
}
