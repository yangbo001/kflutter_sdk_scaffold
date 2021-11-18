import 'package:kflutter_sdk_scaffold/net/response.dart';

import 'api.dart';

abstract class Http {
  /// 添加header
  void addHeader(String key, dynamic value);

  /// 替换所有header(替换掉默认header，不传或传空将清掉默认header)
  void replaceHeader({Map<String, dynamic>? defaultHeaders});

  /// 取消请求
  void cancel();

  /// post请求
  Future<ApiResponse<T>> post<T>(String action, {Map<String, dynamic>? requestBody, ObjectConvertFunc<T>? objectConvertor, ArrayConvertFunc<T>? arrayConvertor});

  /// get请求
  Future<ApiResponse<T>> get<T>(String action, {Map<String, dynamic>? requestBody, ObjectConvertFunc<T>? objectConvertor, ArrayConvertFunc<T>? arrayConvertor});
}
