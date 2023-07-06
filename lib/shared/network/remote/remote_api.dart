import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://student.valuxapps.com/api/',
      receiveDataWhenStatusError: true,
      headers: {'Content-Type': 'application/json'},
    ));
  }

  static Future<Response> getData(
      {required String url, required Map<String, dynamic> properties}) async {
    return await dio.get(url, queryParameters: properties);
  }

  static Future<Response> postData(
      {required String url,
      Map<String, dynamic>? properties,
      required Map<String, dynamic> data}) async {
    return await dio.post(url, queryParameters: properties, data: data);
  }
}
