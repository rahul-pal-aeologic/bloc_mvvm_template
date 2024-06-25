class ApiResponse<T> {
  Status? status;

  T? data;

  String? message;

  ApiResponse.loading(this.message) : status = Status.loading;

  ApiResponse.completed(this.data) : status = Status.completed;

  ApiResponse.error(this.message) : status = Status.error;

  ApiResponse.unNotifiedError(this.message, this.data)
      : status = Status.unNotifiedError;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { loading, completed, error, unNotifiedError }
