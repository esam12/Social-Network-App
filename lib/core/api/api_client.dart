import 'package:dio/dio.dart';
import 'package:social_network_app/core/api/api_config.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:social_network_app/core/api/token/token_interceptor.dart';

class ApiClient {
  Dio getDio({bool tokenInterceptor = false}) {
    final Dio dio = Dio();
    dio.options.baseUrl = ApiConfig.baseUrl;
    if (tokenInterceptor) {
      dio.interceptors.add(TokenInterceptor(dio: dio));
    }
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: false,
      ),
    );
    return dio;
  }
}
