import 'package:advanced_flutter_arabic/app/app_prefs.dart';
import 'package:advanced_flutter_arabic/app/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";

const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String DEFAULT_LANGUAGE = "language";

class DioFactory {
  static late Dio dio;
  static Future getDio() async {
    dio = Dio();

    String language = await AppPreferences.getAppLanguage();
    print(language);
    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      AUTHORIZATION: Constants.token,
      DEFAULT_LANGUAGE: language
    };

    dio.options = BaseOptions(
        baseUrl: Constants.baseUrl,
        headers: headers,
        receiveTimeout: Constants.apiTimeOut,
        sendTimeout: Constants.apiTimeOut);

    if (!kReleaseMode) {
      // its debug mode so print app logs
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }
  }

  static Future<Response> getdata({
    required String url,
    dynamic quary,
  }) async {
    return await dio.get(url, queryParameters: quary);
  }

  static Future<Response> postdata({
    required String url,
    dynamic quary,
    required dynamic data,
  }) async {
    return await dio.post(url, queryParameters: quary, data: data);
  }

  static Future<Response> putdata({
    required String url,
    dynamic quary,
    required dynamic data,
  }) async {
    return await dio.put(url, queryParameters: quary, data: data);
  }
}
