import UIKit
import Flutter
import Firebase
import FirebaseCore
import YandexMapsMobile

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
   // YMKMapKit.setLocale("ru") // Your preferred language. Not required, defaults to system language
    YMKMapKit.setApiKey("63c43aa7-7459-47a2-bdb4-fd1f86ad0255") // Your generated API key
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
