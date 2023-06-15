import UIKit

protocol LoginPresentationLogic {
    func presentLoginSuccess()
    func presentLoginFailed(message: String)
}

class LoginPresenter: LoginPresentationLogic {
    weak var viewController: LoginDisplayLogic?
    
    func presentLoginSuccess() {
        viewController?.displayLoginSuccess()
    }
    
    func presentLoginFailed(message: String) {
        viewController?.displayLoginFailed(message: message)
    }
}
