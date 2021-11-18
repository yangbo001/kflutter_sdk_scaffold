//
// import 'dart:async';
//
// import 'package:flutter/services.dart';

// class KflutterSdkScaffold {
//   static const MethodChannel _channel = MethodChannel('kflutter_sdk_scaffold');
//
//   static Future<String?> get platformVersion async {
//     final String? version = await _channel.invokeMethod('getPlatformVersion');
//     return version;
//   }
// }

library kflutter_scaffold;

export 'net/api.dart';
export 'net/config/envs.dart';
export 'net/http.dart';
export 'net/response.dart';


