@testable import Whalether
import Foundation

class LoginDisplayLogicSpy: LoginDisplayLogic {

    var invokedDisplayLoginSuccess = false
    var invokedDisplayLoginSuccessCount = 0

    func displayLoginSuccess() {
        invokedDisplayLoginSuccess = true
        invokedDisplayLoginSuccessCount += 1
    }

    var invokedDisplayLoginFailed = false
    var invokedDisplayLoginFailedCount = 0
    var invokedDisplayLoginFailedParameters: (message: String, Void)?
    var invokedDisplayLoginFailedParametersList = [(message: String, Void)]()

    func displayLoginFailed(message: String) {
        invokedDisplayLoginFailed = true
        invokedDisplayLoginFailedCount += 1
        invokedDisplayLoginFailedParameters = (message, ())
        invokedDisplayLoginFailedParametersList.append((message, ()))
    }
}
