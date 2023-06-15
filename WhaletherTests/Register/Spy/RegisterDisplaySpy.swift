@testable import Whalether
import Foundation

class RegisterDisplayLogicSpy: RegisterDisplayLogic {

    var invokedDisplayRegisterInfoFailed = false
    var invokedDisplayRegisterInfoFailedCount = 0
    var invokedDisplayRegisterInfoFailedParameters: (message: String, Void)?
    var invokedDisplayRegisterInfoFailedParametersList = [(message: String, Void)]()

    func displayRegisterInfoFailed(message: String) {
        invokedDisplayRegisterInfoFailed = true
        invokedDisplayRegisterInfoFailedCount += 1
        invokedDisplayRegisterInfoFailedParameters = (message, ())
        invokedDisplayRegisterInfoFailedParametersList.append((message, ()))
    }

    var invokedDisplayRegisterSuccess = false
    var invokedDisplayRegisterSuccessCount = 0

    func displayRegisterSuccess() {
        invokedDisplayRegisterSuccess = true
        invokedDisplayRegisterSuccessCount += 1
    }
}
