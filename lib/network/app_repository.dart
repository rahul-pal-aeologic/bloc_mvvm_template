import 'package:bloc_mvvm_template/network/api_client.dart';
import 'package:bloc_mvvm_template/utils/api_endpoints.dart';
import 'package:bloc_mvvm_template/utils/shared_prefs/preference_connector.dart';
import 'package:dio/dio.dart';

class AppRepository {
  DioClient? dioClient;
  PreferenceConnector? preferenceConnector;
  Options? option;

  AppRepository() {
    dioClient = DioClient(Dio(BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
    )));
    option = Options(headers: {
      "Content-Type": "application/json",
    });
    preferenceConnector = PreferenceConnector();
  }

  // //auth module - login
  Future<Response> login() async {
    return Response(
        requestOptions: RequestOptions(path: ApiEndpoints.baseUrl),
        data: {'id': 'userabcdefgh'},
        statusCode: 200);

    // return ((await dioClient!.post(
    //   ApiEndpoints.baseUrl + ApiEndpoints.baseUrl,
    //   data: {},
    //   options: option,
    // )));
  }
}
