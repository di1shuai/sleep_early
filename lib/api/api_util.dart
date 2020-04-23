import 'package:dio/dio.dart';
import 'package:sleep_early/api/api_url.dart';
import 'package:sleep_early/models/api_response.dart';

Map<String, dynamic> optHeader = {
  'accept-language': 'zh-cn',
};

var dio = new Dio(BaseOptions(
    connectTimeout: 30000, headers: optHeader, baseUrl: APIUrl.BASE_URL));

class APIUtil {
  static Future get(String url, [Map<String, dynamic> params]) async {
    print('-------  url : $url  -------');
    Response response;
    APIResponse apiResponse;
    if (params != null) {
      response = await dio.get(url, queryParameters: params);
    } else {
      response = await dio.get(url);
    }
    if (response.statusCode == 200) {
      apiResponse = APIResponse.fromMap(response.data);
    }
    return apiResponse.data;
  }

  static Future post(String url, [Map<String, dynamic> params]) async {
    Response response;
    APIResponse apiResponse;
    response = await dio.post(url, data: params);
    if (response.statusCode == 200) {
      apiResponse = APIResponse.fromMap(response.data);
    }
    return apiResponse.data;
  }

  static Future put(String url, [Map<String, dynamic> params]) async {
    Response response;
    APIResponse apiResponse;
    response = await dio.put(url, data: params);
    if (response.statusCode == 200) {
      apiResponse = APIResponse.fromMap(response.data);
    }
    return apiResponse.data;
  }

  static Future delete(String url) async {
    Response response;
    APIResponse apiResponse;
    response = await dio.delete(url);
    if (response.statusCode == 200) {
      apiResponse = APIResponse.fromMap(response.data);
    }
    return apiResponse.data;
  }
}
