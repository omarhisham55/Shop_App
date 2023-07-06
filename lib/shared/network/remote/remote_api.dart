import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'http://student.valuxapps.com/api/',
      receiveDataWhenStatusError: true,
      headers: {'Content-Type': 'application/json'},
    ));
  }

  static Future<Response> getData({
    required String url,
    required Map<String, dynamic> properties,
    String? lang = 'en',
    String? token,
  }) async {
    dio.options.headers =  {
      'lang': lang,
      'Authorization': token,
    };
    return await dio.get(url, queryParameters: properties);
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? properties,
    String? lang = 'en',
    String? token,
  }) async {
    dio.options.headers =  {
      'lang': lang,
      'Authorization': token,
    };
    return await dio.post(url, queryParameters: properties, data: data);
  }
}
