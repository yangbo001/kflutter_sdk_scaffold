import 'package:flutter/cupertino.dart';

class Config {
  Config._internal();

  static final Config _instance = Config._internal();

  factory Config() => _instance;

  BuildContext? _app;

  set app(BuildContext context) {
    _app ??= context;
  }

  BuildContext get app {
    if (_app == null) {
      throw "please implements base App";
    }
    return _app!;
  }
}

class AppColors {
  static const txtPrimary = Color(0xff333333);
  static const txtSecond = Color(0xff666666);
  static const txtThird = Color(0xff999999);

  static const Color appPrimary = Color(0xff1989fa);
  static const Color appAccent = Color(0xff265cfd);
  static const Color appDark = Color(0xff265cfd);
}
