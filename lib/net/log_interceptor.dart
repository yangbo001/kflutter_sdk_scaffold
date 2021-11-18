import 'package:dio/dio.dart';

extension _Map2StringExtensions on Map {
  String mapToStructureString({int indentation = 2}) {
    String result = "";
    String indentationStr = " " * indentation;
    result += "{";
    forEach((key, value) {
      if (value is Map) {
        var temp = value.mapToStructureString(indentation: indentation + 2);
        result += "\n$indentationStr  \"$key\" : $temp,";
      } else if (value is List) {
        result += "\n$indentationStr  \"$key\" : ${value.listToStructureString(indentation: indentation + 2)},";
      } else {
        result += "\n$indentationStr  \"$key\" : \"$value\",";
      }
    });
    result = result.substring(0, result.length - 1);
    result += indentation == 2 ? "\n}" : "\n${" " * (indentation - 1)}}";
    return result;
  }
}

extension _List2StringExtensions on List {
  String listToStructureString({int indentation = 2}) {
    String result = "";
    String indentationStr = " " * indentation;
    result += "$indentationStr[";
    for (var value in this) {
      if (value is Map) {
        var temp = value.mapToStructureString(indentation: indentation + 2);
        result += "\n$indentationStr \"$temp\",";
      } else if (value is List) {
        result += value.listToStructureString(indentation: indentation + 2);
      } else {
        result += "\n$indentationStr \"$value\",";
      }
    }
    result = result.substring(0, result.length - 1);
    result += "\n$indentationStr]";
    return result;
  }
}

///日志拦截器
class DioLogInterceptor extends Interceptor {
  String _parseResponse(Response? response) {
    String responseStr = "";
    var data = response?.data;
    if (data is Map) {
      responseStr += data.mapToStructureString();
    } else if (data is List) {
      responseStr += data.listToStructureString();
    } else {
      responseStr += data.toString();
    }
    return responseStr;
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
    @override
    Future onRequest(RequestOptions options) async {
      String requestStr = "\n==================== REQUEST ====================\n"
          "- URL:\n${options.baseUrl + options.path}\n"
          "- METHOD: ${options.method}\n";

      requestStr += "- HEADER:\n${options.headers.mapToStructureString()}\n";

      final data = options.data;
      if (data != null) {
        if (data is Map) {
          requestStr += "- BODY:\n${data.mapToStructureString()}\n";
        } else if (data is FormData) {
          final formDataMap = Map()
            ..addEntries(data.fields)
            ..addEntries(data.files);
          requestStr += "- BODY:\n${formDataMap.mapToStructureString()}\n";
        } else {
          requestStr += "- BODY:\n${data.toString()}\n";
        }
      }
      print(requestStr);
      return options;
    }

    @override
    Future onError(DioError err) async {
      String errorStr = "\n==================== RESPONSE ====================\n"
          "- URL:\n${err.requestOptions.baseUrl + err.requestOptions.path}\n"
          "- METHOD: ${err.requestOptions.method}\n";

      if (err.response != null && err.response?.data != null) {
        errorStr += "- ERROR:\n${_parseResponse(err.response)}\n";
      } else {
        errorStr += "- ERRORTYPE: ${err.type}\n";
        errorStr += "- MSG: ${err.message}\n";
      }
      print(errorStr);
      return err;
    }

    void printWrapped(String text) {
      final pattern = RegExp('.{1,800}');
      pattern.allMatches(text).forEach((match) => print(match.group(0)));
    }

    @override
    Future onResponse(Response response) async {
      String responseStr = "\n==================== RESPONSE ====================\n"
          "- URL:\n${response.requestOptions.uri}\n";
      responseStr += "- HEADER:\n{";
      response.headers.forEach((key, list) => responseStr += "\n  \"$key\" : \"$list\",");
      responseStr += "\n}\n";
      responseStr += "- STATUS: ${response.statusCode}\n";

      if (response.data != null) {
        responseStr += "- BODY:\n ${_parseResponse(response)}";
      }
      printWrapped(responseStr);
      return response;
    }
  }
}
