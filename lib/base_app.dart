import 'package:alsc_saas_kflutter_sdk_scaffold/configs/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 创建一个自定义的Binding，继承和with的关系如下，里面什么都不用写(flutter boost)
class _CustomFlutterBinding extends WidgetsFlutterBinding with BoostFlutterBinding {}

/// main-runApp()主函数的app基类
abstract class BaseApp extends StatelessWidget with GlobalPageVisibilityObserver {
  BaseApp({Key? key}) : super(key: key) {
    /// 这里的CustomFlutterBinding调用务必不可缺少，用于控制Boost状态的resume和pause
    _CustomFlutterBinding();
    PageVisibilityBinding.instance.addGlobalObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    _init(context);
    return ScreenUtilInit(
      designSize: appDesignSize(),
      builder: () => MaterialApp(
        builder: EasyLoading.init(),
        debugShowCheckedModeBanner: false,
        title: appTitle(),
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.blue,
          textTheme: TextTheme(
            headline1: TextStyle(fontSize: 70.sp, color: AppColors.txtPrimary),
            headline2: TextStyle(fontSize: 60.sp, color: AppColors.txtPrimary),
            headline3: TextStyle(fontSize: 50.sp, color: AppColors.txtPrimary),
            headline4: TextStyle(fontSize: 40.sp, color: AppColors.txtPrimary),
            headline5: TextStyle(fontSize: 30.sp, color: AppColors.txtPrimary),
            headline6: TextStyle(fontSize: 20.sp, color: AppColors.txtPrimary),
            subtitle1: TextStyle(fontSize: 18.sp, color: AppColors.txtPrimary),
            subtitle2: TextStyle(fontSize: 16.sp, color: AppColors.txtPrimary),
            button: TextStyle(fontSize: 15.sp, color: AppColors.txtPrimary),
            bodyText1: TextStyle(fontSize: 14.sp, color: AppColors.txtPrimary),
            bodyText2: TextStyle(fontSize: 14.sp, color: AppColors.txtSecond),
            caption: TextStyle(fontSize: 12.sp, color: AppColors.txtThird),
          ),
        ),
        home: FlutterBoostApp((RouteSettings settings, String? uniqueId) => flutterBoostRouter()[settings.name]?.call(settings, uniqueId)),
      ),
    );
  }

  /// app title
  String appTitle();

  /// app 设计尺寸
  Size appDesignSize();

  /// flutter boost router
  Map<String, FlutterBoostRouteFactory> flutterBoostRouter();
}

/// 初始化工作
void _init(BuildContext context) {
  Config().app = context;
  _initLoadingProgress();
}

/// 初始化加载loading
void _initLoadingProgress() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..backgroundColor = Colors.black.withOpacity(0.3);
}
