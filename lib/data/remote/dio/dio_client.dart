import 'dart:io';
import 'package:daif_owner/view/basewidget/custom_loading_overlay.dart';
import 'package:dio/src/response.dart';
import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../../../main.dart';
import '../../../utill/app_constants.dart';
import 'logging_interceptor.dart';

class DioClient {
  final String baseUrl = AppConstants.baseUrl;
  final LoggingInterceptor loggingInterceptor =
      LoggingInterceptor.loggingInterceptorInstance;
  final Dio dio = Dio();
  late String? token;
  static final dioClient = DioClient._();

  DioClient._() {
    token = userInfo?.accessToken;
    dio
      ..options.baseUrl = baseUrl
      ..options.headers = {
        "Accept": "application/json",
        ...userInfo?.getRequestHeaders() ?? {}
      }
      ..options.connectTimeout = 60000
      ..options.receiveTimeout = 60000
      ..httpClientAdapter;
    dio.interceptors.add(loggingInterceptor);
  }

//"Content-type": "multipart/form-data"
  Future<Response> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    return showLoadingOverLayForAPI(asyncFunction: () async {
      try {
        var response = await dio.get(
          uri,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
        );
        return response;
      } on SocketException catch (e) {
        throw SocketException(e.toString());
      } on FormatException catch (_) {
        rethrow;
      } catch (e) {
        rethrow;
      }
    });
  }

  Future<Response> post(
    String uri, {
    required data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    ProgressCallback? onSendProgress,
  }) async {
    return showLoadingOverLayForAPI(
      asyncFunction: () async {
        try {
          final Response response = await dio.post(
            uri,
            data: data,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress,
          );
          return response;
        } on FormatException catch (_) {
          rethrow;
        } catch (e) {
          rethrow;
        }
      },
    );
  }

  Future<Response> put(
    String uri, {
    required data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    ProgressCallback? onSendProgress,
  }) async {
    try {
      var response = await dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(
    String uri, {
    required data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      var response = await dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

// void updateHeader({String? token, String? countryCode}) {
//   if (token != null) {
//     this.token = token;
//   }
//   countryCode = countryCode == null
//       ? this.countryCode == 'US'
//       ? 'en'
//       : this.countryCode!.toLowerCase()
//       : countryCode == 'US'
//       ? 'en'
//       : countryCode.toLowerCase();
//   this.countryCode = countryCode;
//   dio.options.headers = {
//     'Content-Type': 'application/json; charset=UTF-8',
//     'Authorization': 'Bearer ${this.token}',
//     AppConstants.langKey:
//     countryCode == 'US' ? 'en' : countryCode.toLowerCase(),
//   };
// }
}
