@testable import Whalether
import Foundation

class LoginPresentationLogicSpy: LoginPresentationLogic {

    var invokedPresentLoginSuccess = false
    var invokedPresentLoginSuccessCount = 0

    func presentLoginSuccess() {
        invokedPresentLoginSuccess = true
        invokedPresentLoginSuccessCount += 1
    }

    var invokedPresentLoginFailed = false
    var invokedPresentLoginFailedCount = 0
    var invokedPresentLoginFailedParameters: (message: String, Void)?
    var invokedPresentLoginFailedParametersList = [(message: String, Void)]()

    func presentLoginFailed(message: String) {
        invokedPresentLoginFailed = true
        invokedPresentLoginFailedCount += 1
        invokedPresentLoginFailedParameters = (message, ())
        invokedPresentLoginFailedParametersList.append((message, ()))
    }
}
