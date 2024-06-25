
import 'dart:io';

import 'package:bloc_mvvm_template/network/interceptors/request_retrier.dart';
import 'package:bloc_mvvm_template/utils/logger_helper.dart';
import 'package:dio/dio.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  final RequestRetrier requestRetrier;
  final int _maxCharactersPerLine = 200;
  RetryOnConnectionChangeInterceptor({
    required this.requestRetrier,
  });

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.unknown &&
        err.error != null &&
        err.error is SocketException;
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err)) {
      try {
        return requestRetrier.scheduleRequestRetry(err.requestOptions);
      } catch (e) {
        return e;
      }
    }
    return err;
    // super.onError(err, handler);
  }

  // @override
  // void onError(DioError err, ErrorInterceptorHandler handler) {
  //   LoggerHelper.printLogValue("Error: ${handleError(err)}");
  //   super.onError(err, handler);
  // }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    LoggerHelper.printLogValue("Request: --> ${options.method} ${options.path}");
    LoggerHelper.printLogValue("Content type: ${options.contentType}");
    LoggerHelper.printLogValue("<-- END HTTP");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // LoggerHelper.printLogValue("Response: ${response.data.toString()}");
    LoggerHelper.printLogValue(
        "Response: <-- ${response.statusCode} ${response.data.method} ${response.data.path}");
    String responseAsString = response.data.toString();
    if (responseAsString.length > _maxCharactersPerLine) {
      int iterations =
          (responseAsString.length / _maxCharactersPerLine).floor();
      for (int i = 0; i <= iterations; i++) {
        int endingIndex = i * _maxCharactersPerLine + _maxCharactersPerLine;
        if (endingIndex > responseAsString.length) {
          endingIndex = responseAsString.length;
        }
        print(
            responseAsString.substring(i * _maxCharactersPerLine, endingIndex));
      }
    } else {
      print(response.data);
    }
    print("<-- END HTTP");
    super.onResponse(response, handler);
  }
}
