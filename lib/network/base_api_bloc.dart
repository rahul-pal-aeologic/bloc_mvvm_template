
import 'dart:async';

import 'package:bloc_mvvm_template/network/api_response.dart';
import 'package:flutter/material.dart';

/// [BaseApiBloc] is wrapper class that provide the base for the streams for api handling
/// BaseApi bloc has the [ApiResponse] class support which provide us the [Status] of the api
class BaseApiBloc<@required T> {
  final StreamController<ApiResponse<T>> _streamController =
      StreamController<ApiResponse<T>>.broadcast();

  StreamSink<ApiResponse<T>> get _apiDataSink => _streamController.sink;

  Stream<ApiResponse<T>> get apiDataSinkStream => _streamController.stream;

  streamDispose() {
    _streamController.close();
  }

  Status? _currentStatus;

  /// [isLoading] ,[isCompleted] ,[hasError] ,[hasUnNotifiedError] will provide the current status of the api status
  ///
  bool get isLoading => _currentStatus == Status.loading;

  bool get isCompleted => _currentStatus == Status.completed;

  bool get hasError => _currentStatus == Status.error;

  bool get hasUnNotifiedError => _currentStatus == Status.unNotifiedError;

  /// This is the first thing you should do when you hit and api , it will set the api status to loading
  ///
  ///  startLoading("Loading...");
  ///
  void startLoading(String message) {
    _currentStatus = Status.loading;
    _apiDataSink.add(ApiResponse.loading(message));
  }

  /// When the api is fetched you need to provide the the data into the stream
  ///
  void addDataToStream(T data) {
    _currentStatus = Status.completed;
    _apiDataSink.add(ApiResponse.completed(data));
  }

  ///  When we receive the error in the api we need to check for it and pass the message into the stream so the user will notify it
  //
  void addErrorToStream(String errorMessage) {
    _currentStatus = Status.error;
    _apiDataSink.add(ApiResponse.error(errorMessage));
  }

  ///  When you need to update the api but do not want to update the UI for the error , you can use [addUnNotifiedErrorToStream]
  ///
  ///  You can also use the [onError] to update anything if any error occurs
  void addUnNotifiedErrorToStream(String errorMessage, T previousLoadedData) {
    _currentStatus = Status.unNotifiedError;
    if (previousLoadedData == null) {
      String errorMessage =
          "$T typedata is null, Make sure the data is not null other vise use the addErrorToStream method";

      _apiDataSink.addError(Exception(errorMessage));
      throw Exception(errorMessage);
    }

    _apiDataSink
        .add(ApiResponse.unNotifiedError(errorMessage, previousLoadedData));
  }

  /// [onDataComplete] is a listener when the data is entered into stream but you cannot use the where the UI is building , it will through markneedsrebuild
  ///
  ///     exerciseBloc.onDataComplete((value) {
  ///
  ///      setItemStatus(common_widget.contentID, value.item.type, common_widget.isNew);
  ///
  ///    });
  ///
  onDataComplete(ValueChanged<T> data) {
    apiDataSinkStream.listen((ApiResponse<T> event) {
      if (event.status == Status.completed) {
        data(event.data!);
      }
    });
  }

  /// [onError] is a listenr which will also provide the error message is any error is passed into the stream
  onError(ValueChanged<String> data) {
    apiDataSinkStream.listen((ApiResponse<T> event) {
      if (event.status == Status.unNotifiedError ||
          event.status == Status.error) {
        data(event.message!);
      }
    });
  }
}

extension E<T> on Future<T> {
  when(ValueChanged<T> data, ValueChanged<String> error) {
    then((value) {
      data(value);
    }).catchError((e) {
      error(e.toString());
    });
  }
}
