import UIKit

@objc protocol LoginRoutingLogic {
    func routeToRegisterPage()
}

protocol LoginDataPassing {
    var dataStore: LoginDataStore? { get }
}

class LoginRouter: NSObject, LoginRoutingLogic, LoginDataPassing {
    weak var viewController: LoginViewController?
    var dataStore: LoginDataStore?
    
    func routeToRegisterPage() {
        guard let vc: RegisterViewController = RegisterViewController.initiated() else { return }
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
