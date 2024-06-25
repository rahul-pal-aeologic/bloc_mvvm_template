import 'package:bloc_mvvm_template/network/api_response.dart';
import 'package:flutter/material.dart';

typedef ApiValueWidget<String> = Widget Function(String message);
typedef ApiDataWidget<T> = Widget Function(T value);

class ApiStreamBuilder<T> extends StatelessWidget {
  final Stream<ApiResponse<T>> stream;
  final ApiDataWidget<T> dataWidget;
  final ApiValueWidget<String> loadingWidget;
  final ApiValueWidget<String> errorWidget;
  final bool showLoadingInitially;

  const ApiStreamBuilder(
      {super.key, required this.stream,
      required this.dataWidget,
      required this.loadingWidget,
      required this.errorWidget,
      this.showLoadingInitially = true});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ApiResponse<T>>(
      stream: stream,
      initialData: showLoadingInitially ? ApiResponse.loading("Loading") : null,
      builder: (context, AsyncSnapshot<ApiResponse<T>> snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.data!.status) {
            case Status.loading:
              return loadingWidget(snapshot.data!.message!);
            case Status.completed:
              return dataWidget(snapshot.data!.data!);
            case Status.unNotifiedError:
              return dataWidget(snapshot.data!.data!);
            case Status.error:
              return errorWidget(snapshot.data!.message!);
            default:
              return loadingWidget(snapshot.data!.message!);
          }
        }
        return Container();
      },
    );
  }
}
