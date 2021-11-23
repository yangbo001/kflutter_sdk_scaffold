import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

/// loading 事件
mixin _Loading {
  showLoadingProgress({String message = "加载中..."}) {
    EasyLoading.show(status: message, maskType: EasyLoadingMaskType.clear);
  }

  dismissLoadingProgress() {
    EasyLoading.dismiss();
  }

  showResultTip(String message, {bool error = false}) {
    if (error) {
      EasyLoading.showError(message, dismissOnTap: true, duration: const Duration(milliseconds: 2000), maskType: EasyLoadingMaskType.clear);
    } else {
      EasyLoading.showSuccess(message, dismissOnTap: true, duration: const Duration(milliseconds: 2000), maskType: EasyLoadingMaskType.clear);
    }
  }
}

/// statelesswidget基类
abstract class BaseStatelessWidget extends StatelessWidget with _Loading {
  const BaseStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildcontent(context);
  }

  Widget buildcontent(BuildContext context);
}

/// statefulwidget-state基类
abstract class BaseState extends State with _Loading {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildcontent(context);
  }

  Widget buildcontent(BuildContext context);
}

/// base页面
abstract class BasePage extends BaseStatelessWidget {
  const BasePage({Key? key}) : super(key: key);
}

/// 页面
abstract class CubitPage<T extends BaseCubit<S>, S> extends BasePage {
  final Map<String, dynamic> _pageMap = {};

  CubitPage({Key? key}) : super(key: key);

  @override
  Widget buildcontent(BuildContext context) {
    _pageMap["context"] = context;
    return BlocProvider(
      create: (_) => _createCubit(),
      child: BlocListener<T, S>(
        bloc: _createCubit().._delayInvokeOncreate(),
        listener: (context, state) => onStateDataChanged(state),
        child: BlocBuilder<T, S>(
          builder: (context, state) {
            return buildContent(context, context.read<T>(), state);
          },
        ),
      ),
    );
  }

  T _createCubit() {
    if (_pageMap["cubit"] == null) {
      T cubit = createCubit();
      _pageMap["cubit"] = cubit;
    }
    return _pageMap["cubit"];
  }

  /// 创建cubit逻辑实例
  T createCubit();

  /// 当state数据发生变化时
  void onStateDataChanged(S state);

  /// 创建视图方法
  Widget buildContent(BuildContext context, T cubit, S state);

  /// 获取BuildContext对象，只能在buildContent（）调用之后有效
  BuildContext? get context => _pageMap["context"];

  /// 获取cubit逻辑处理，只能在buildContent（）调用之后有效
  T? getCubit() => context?.read<T>();
}

abstract class BaseCubit<State> extends Cubit<State> {
  bool oncreateInvoking = false;

  BaseCubit(State initialState) : super(initialState);

  Future<dynamic> onCreate();

  /// 延时1毫秒调用onCreate()等待全局事件监听注册完成
  void _delayInvokeOncreate() async {
    if (oncreateInvoking) return;
    await Future.delayed(const Duration(milliseconds: 1));
    oncreateInvoking = true;
    await onCreate();
    oncreateInvoking = false;
  }
}
