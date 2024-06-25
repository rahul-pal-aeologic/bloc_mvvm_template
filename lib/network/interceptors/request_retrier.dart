import 'dart:async';
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class RequestRetrier {
  final Dio dio;
  final Connectivity connectivity;

  RequestRetrier({
    required this.dio,
    required this.connectivity,
  });

  Future<Response> scheduleRequestRetry(RequestOptions requestOptions) async {
    final responseCompleter = Completer<Response>();
    StreamSubscription? streamSubscription;
    streamSubscription = connectivity.onConnectivityChanged.listen(
      (connectivityResult) {
        if (!(connectivityResult.contains(ConnectivityResult.none))) {
          streamSubscription!.cancel();
          responseCompleter.complete(
            dio.request(
              requestOptions.path,
              cancelToken: requestOptions.cancelToken,
              data: requestOptions.data,
              onReceiveProgress: requestOptions.onReceiveProgress,
              onSendProgress: requestOptions.onSendProgress,
              queryParameters: requestOptions.queryParameters,
              // options: requestOptions,//todo
            ),
          );
        }
      },
    );

    return responseCompleter.future;
  }
}
