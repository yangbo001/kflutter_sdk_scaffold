import 'package:alsc_saas_kflutter_sdk_scaffold/configs/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kflutter_sdk_resource/generated/l10n.dart';

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
///             headline1: TextStyle(fontSize: 70.sp, color: AppColors.txtPrimary),
///             headline2: TextStyle(fontSize: 60.sp, color: AppColors.txtPrimary),
///             headline3: TextStyle(fontSize: 50.sp, color: AppColors.txtPrimary),
///             headline4: TextStyle(fontSize: 40.sp, color: AppColors.txtPrimary),
///             headline5: TextStyle(fontSize: 30.sp, color: AppColors.txtPrimary),
///             headline6: TextStyle(fontSize: 20.sp, color: AppColors.txtPrimary),
///             subtitle1: TextStyle(fontSize: 18.sp, color: AppColors.txtPrimary),
///             subtitle2: TextStyle(fontSize: 16.sp, color: AppColors.txtPrimary),
///             button: TextStyle(fontSize: 15.sp, color: AppColors.txtPrimary),
///             bodyText1: TextStyle(fontSize: 14.sp, color: AppColors.txtPrimary),
///             bodyText2: TextStyle(fontSize: 14.sp, color: AppColors.txtSecond),
///             caption: TextStyle(fontSize: 12.sp, color: AppColors.txtThird),
TextTheme get textTheme => Theme.of(getApp()).textTheme;

/// 国际化实例
S get l10n => S.current;
