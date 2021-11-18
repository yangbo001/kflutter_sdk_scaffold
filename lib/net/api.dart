import 'package:dio/dio.dart';
import 'dart:convert' as convert;
import 'package:kflutter_sdk_scaffold/net/config/envs.dart';
import 'package:kflutter_sdk_scaffold/net/http.dart';
import 'package:kflutter_sdk_scaffold/net/response.dart';

import 'config/env_urls.dart';
import 'log_interceptor.dart';

/// @description object转换器
typedef ObjectConvertFunc<T> = T Function(Map<String, dynamic> data);

/// @description array转换器
typedef ArrayConvertFunc<T> = T Function(List<dynamic> list);

///网络请求
class Api {
  Api._internal();

  static final Api _instance = Api._internal();

  factory Api() => _instance;

  EnvUrl? envUrl;

  final Map<String, dynamic> _headers = {};

  /// 设置网络请求环境（只能设置一次）
  void setEnv(EnvEnum envEnum) {
    envUrl ??= getEnvUrl(envEnum);
  }

  /// 设置默认头信息（只能设置一次）
  void setDefaultHeader(Map<String, dynamic> header) {
    if (_headers.isEmpty) _headers.addAll(header);
  }

  /// 重置清空设置信息
  void reset() {
    envUrl = null;
    _headers.clear();
  }

  /// 获取网络请求baseUrl
  /// baseUrl指定url；默认获取baseurl
  Http http({String? assigned}) {
    try {
      return _HttpRequest(assigned ?? envUrl!.getBaseUrl());
    } catch (e) {
      throw "please set env";
    }
  }

  /// 获取zbrd请求
  Http zbrd() {
    try {
      return _HttpRequest(envUrl!.getZbrdUrl());
    } catch (e) {
      throw "please set env";
    }
  }

  /// 获取light请求
  Http light() {
    try {
      return _HttpRequest(envUrl!.getLightBaseUrl());
    } catch (e) {
      throw "please set env";
    }
  }
}

class _HttpRequest implements Http {
  String baseUrl;
  late Dio _dio;
  final Map<String, dynamic> _headers = {};
  CancelToken token = CancelToken();

  _HttpRequest(this.baseUrl, {Map<String, dynamic>? defaultHeaders}) {
    _dio = Dio(BaseOptions(baseUrl: baseUrl, connectTimeout: 8000));
    _dio.interceptors.add(DioLogInterceptor());
    if (defaultHeaders != null) {
      _headers.addAll(defaultHeaders);
    }
  }

  @override
  void addHeader(String key, dynamic value) {
    _headers[key] = value;
  }

  @override
  void replaceHeader({Map<String, dynamic>? defaultHeaders}) {
    _headers.clear();
    if (defaultHeaders != null) defaultHeaders.addAll(defaultHeaders);
  }

  @override
  void cancel() {}

  @override
  Future<ApiResponse<T>> post<T>(String action, {Map<String, dynamic>? requestBody, ObjectConvertFunc<T>? objectConvertor, ArrayConvertFunc<T>? arrayConvertor}) async {
    Response resp = await _dio.post(action, queryParameters: requestBody, options: Options(headers: _headers), cancelToken: token);
    return _handleResp(resp, objectConvertor: objectConvertor, arrayConvertor: arrayConvertor);
  }

  @override
  Future<ApiResponse<T>> get<T>(String action, {Map<String, dynamic>? requestBody, ObjectConvertFunc<T>? objectConvertor, ArrayConvertFunc<T>? arrayConvertor}) async {
    Response resp = await _dio.get(action, queryParameters: requestBody, options: Options(headers: _headers), cancelToken: token);
    return _handleResp(resp, objectConvertor: objectConvertor, arrayConvertor: arrayConvertor);
  }

  ApiResponse<T> _handleResp<T>(Response resp, {ObjectConvertFunc<T>? objectConvertor, ArrayConvertFunc<T>? arrayConvertor}) {
    if (resp.statusCode == 200) {
      if (objectConvertor == null && arrayConvertor == null) {
        return ApiResponse.pack(data: resp.data as T, code: successStatusCode);
      } else {
        String source = resp.data.toString();
        try {
          Map<String, dynamic> respMap = convert.jsonDecode(source);
          int code = respMap['status'];
          if (ApiResponse.isSuccess(code)) {
            if (objectConvertor != null) {
              return ApiResponse.pack(code: code, data: objectConvertor.call(respMap['content'] ?? {}), message: "success");
            } else if (arrayConvertor != null) {
              return ApiResponse.pack(code: code, data: arrayConvertor.call(respMap['content'] ?? []), message: "success");
            } else {
              return ApiResponse.pack(code: code, data: respMap['data'], message: "success");
            }
          } else {
            return ApiResponse.pack(code: code, message: respMap['message']);
          }
        } catch (e, stack) {
          print(stack.toString() + "\n" + e.toString());
          return ApiResponse.pack(code: -1, message: "ERROR_INTERNAL");
        }
      }
    } else {
      return ApiResponse.pack(code: resp.statusCode, message: resp.statusMessage);
    }
  }
}
