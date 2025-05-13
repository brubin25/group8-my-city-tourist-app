import UIKit
import Flutter
import GoogleMaps // ✅ Import Google Maps

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // ✅ Provide your API key here
    GMSServices.provideAPIKey("AIzaSyBpit3wvM7VvwXmR-gJlZ855-ih1mJat1YX")

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}