import FirebaseCore
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        UserProfile.shared.getProfile()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let vc = WeatherViewController.initiated()
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
        return true
    }
}

