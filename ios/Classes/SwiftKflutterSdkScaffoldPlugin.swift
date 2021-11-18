import Flutter
import UIKit

public class SwiftKflutterSdkScaffoldPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "kflutter_sdk_scaffold", binaryMessenger: registrar.messenger())
    let instance = SwiftKflutterSdkScaffoldPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
