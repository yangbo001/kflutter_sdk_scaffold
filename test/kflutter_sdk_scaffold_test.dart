import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kflutter_sdk_scaffold/kflutter_sdk_scaffold.dart';

void main() {
  const MethodChannel channel = MethodChannel('kflutter_sdk_scaffold');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await KflutterSdkScaffold.platformVersion, '42');
  });
}
