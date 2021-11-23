import 'package:alsc_saas_kflutter_sdk_scaffold/configs/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(
  String? message, {
  Toast during = Toast.LENGTH_SHORT,
}) {
  if (message == null || message.isEmpty) {
    return;
  }
  Fluttertoast.showToast(
    msg: message,
    toastLength: during,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.black87,
    textColor: Colors.white,
    fontSize: 15.sp,
  );
}

/// 获取app context
BuildContext getApp() => Config().app;

/// 获取app全局字体Size设置
TextTheme get textTheme => Theme.of(getApp()).textTheme;
