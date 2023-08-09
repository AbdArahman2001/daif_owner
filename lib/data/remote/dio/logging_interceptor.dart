import 'dart:developer';

import 'package:daif_owner/main.dart';
import 'package:dio/dio.dart';

class LoggingInterceptor extends InterceptorsWrapper {
  int maxCharactersPerLine = 200;
  LoggingInterceptor._();
  static final loggingInterceptorInstance = LoggingInterceptor._();
  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    log("--> ${options.method} ${options.path}");
    log("Headers: ${options.headers.toString()}");
    log("queryParameters: ${options.queryParameters.toString()}");
    log("data: ${options.data.toString()}");
    log("<-- END HTTP");

    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(Response response, ResponseInterceptorHandler handler) async {

    log(
        "<-- ${response.statusCode} ${response.requestOptions.method} ${response.requestOptions.path}");

    String responseAsString = response.data.toString();

    if (responseAsString.length > maxCharactersPerLine) {
      int iterations = (responseAsString.length / maxCharactersPerLine).floor();
      for (int i = 0; i <= iterations; i++) {
        int endingIndex = i * maxCharactersPerLine + maxCharactersPerLine;
        if (endingIndex > responseAsString.length) {
          endingIndex = responseAsString.length;
        }
        log(
            responseAsString.substring(i * maxCharactersPerLine, endingIndex));
      }
    } else {
      log(response.data.toString());
    }

    log("<-- END HTTP");

    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    log("ERROR[${err?.response?.statusCode}] => PATH: ${err?.requestOptions?.path}");
    log("Error Data ${err?.response?.data}");
    log("Error${err?.error}");
    log("Error message ${err?.message}");
    log("Error status message ${err?.response?.statusMessage}");
    return super.onError(err, handler);
  }

}
