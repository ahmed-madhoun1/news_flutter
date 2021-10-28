import 'package:dio/dio.dart';
import 'package:news_flutter/shared/components/constants.dart';

class DioHelper {
  static late Dio dio;

  /// Initialize dio
  static init() {
    dio = Dio(
        BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
    ));
  }

  /// Get Data From Database
  static Future<Response> getData({required String url, required Map<String, dynamic> query}) async {
    return await dio.get(url, queryParameters: query);
  }
}
