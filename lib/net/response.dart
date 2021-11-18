const successStatusCode = 1000;

class ApiResponse<T> {
  int? status;
  String? message;
  T? content;

  ApiResponse(this.status, this.message, this.content);

  bool success() {
    return isSuccess(status);
  }

  factory ApiResponse.pack({T? data, int? code, String? message}) {
    return ApiResponse(code, message, data);
  }

  static bool isSuccess(int? code) {
    return code == successStatusCode || code == 0;
  }
}
