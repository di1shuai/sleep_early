import 'package:dio/dio.dart';
import 'package:sleep_early/api/api_url.dart';

Map<String, dynamic> optHeader = {
  'accept-language': 'zh-cn',
  'content-type': 'application/json'
};

var dio = new Dio(BaseOptions(connectTimeout: 30000, headers: optHeader,baseUrl: APIUrl.BASE_URL));

class APIUtil {
  static Future get(String url, [Map<String, dynamic> params]) async {
    Response response;

    if (params != null) {
      response = await dio.get(url, queryParameters: params);
    } else {
      response = await dio.get(url);
    }
    return response.data;
  }

  static Future post(String url, [Map<String, dynamic> params]) async {
    Response response;
    response = await dio.post(url, data: params);
    return response.data;
  }


}
