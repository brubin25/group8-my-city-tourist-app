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
    GMSServices.provideAPIKey("AIzaSyAoqQklIP-XMX2ARV-t8NCBOqZD_jfF8zA")

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
