import UIKit
import Flutter
import GoogleMaps
import flutter_local_notifications

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    GMSServices.provideAPIKey("AIzaSyBJiz0uuu-wjfM3GyqimCxP0E3RvMpAgeg")
    
    GeneratedPluginRegistrant.register(with: self)
    
    if #available(iOS 10.0, *) {
        UNUserNotificationCenter.current().delegate = self
    }
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
