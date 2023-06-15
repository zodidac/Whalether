import UIKit

protocol RegisterPresentationLogic {
    func presentRegisterSuccess()
    func presentRegisterInfoFailed(message: String)
}

class RegisterPresenter: RegisterPresentationLogic {
    weak var viewController: RegisterDisplayLogic?
    
    func presentRegisterInfoFailed(message: String) {
        viewController?.displayRegisterInfoFailed(message: message)
    }
    
    func presentRegisterSuccess() {
        viewController?.displayRegisterSuccess()
    }
}
