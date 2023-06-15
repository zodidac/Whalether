
import UIKit

@objc protocol WeatherRoutingLogic {
    func routeToUserProfile()
}

protocol WeatherDataPassing {
    var dataStore: WeatherDataStore? { get }
}

class WeatherRouter: NSObject, WeatherRoutingLogic, WeatherDataPassing {
    weak var viewController: WeatherViewController?
    var dataStore: WeatherDataStore?
    
    func routeToUserProfile() {
        guard let _ = UserProfile.shared.getProfile() else {
            guard let vc = LoginViewController.initiated() else { return }
            let nav = UINavigationController(rootViewController: vc)
            self.viewController?.present(nav, animated: true)
            return
        }
        guard let vc = UserProfileViewController.initiated() else { return }
        self.viewController?.present(vc, animated: true)
        
    }
}
