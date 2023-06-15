@testable import Whalether
import Foundation

class RegisterPresentationLogicSpy: RegisterPresentationLogic {
    var invokedPresentRegisterSuccess = false
    var invokedPresentRegisterSuccessCount = 0

    func presentRegisterSuccess() {
        invokedPresentRegisterSuccess = true
        invokedPresentRegisterSuccessCount += 1
    }

    var invokedPresentRegisterInfoFailed = false
    var invokedPresentRegisterInfoFailedCount = 0
    var invokedPresentRegisterInfoFailedParameters: (message: String, Void)?
    var invokedPresentRegisterInfoFailedParametersList = [(message: String, Void)]()

    func presentRegisterInfoFailed(message: String) {
        invokedPresentRegisterInfoFailed = true
        invokedPresentRegisterInfoFailedCount += 1
        invokedPresentRegisterInfoFailedParameters = (message, ())
        invokedPresentRegisterInfoFailedParametersList.append((message, ()))
    }
}
