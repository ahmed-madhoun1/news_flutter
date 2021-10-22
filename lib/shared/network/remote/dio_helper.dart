import 'package:dio/dio.dart';
import 'package:news_flutter/shared/components/constants.dart';

class DioHelper {
  static late Dio dio;

  /// Initialize dio
  static init() {
    dio = Dio(BaseOptions(
      baseUrl: BASE_URL,
      receiveDataWhenStatusError: true,
    ));
  }
}
