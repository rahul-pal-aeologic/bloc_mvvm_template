import 'dart:io';

import 'package:bloc_mvvm_template/utils/app_strings.dart';
import 'package:bloc_mvvm_template/utils/logger_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioClient {
  // dio instance
  final Dio _dio;

  // injecting dio instance
  DioClient(this._dio) {
    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
          responseBody: true,
          error: true,
          requestHeader: false,
          responseHeader: false,
          request: false,
          requestBody: true));
    }
  }

  // Get:-----------------------------------------------------------------------
  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      return response.data;
    } on SocketException catch (e) {
      LoggerHelper.printError(e.toString());
      throw SocketException(e.toString());
    } on FormatException catch (e) {
      LoggerHelper.printError("Error::${e.toString()}");
      throw const FormatException(AppStrings.unableToProcessTheData);
    } catch (e) {
      rethrow;
    }
  }

  // Post:----------------------------------------------------------------------
  Future<dynamic> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return response.data;
    } on FormatException catch (e) {
      LoggerHelper.printError("Error::${e.toString()}");
      throw const FormatException(AppStrings.unableToProcessTheData);
    } catch (e) {
      rethrow;
    }
  }

  // PUT:----------------------------------------------------------------------
  Future<dynamic> put(
    String uri, {
    data,
    required Map<String, dynamic> queryParameters,
    required Options options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return response.data;
    } on FormatException catch (e) {
      LoggerHelper.printError("Error::${e.toString()}");
      throw const FormatException(AppStrings.unableToProcessTheData);
    } catch (e) {
      rethrow;
    }
  }
}
