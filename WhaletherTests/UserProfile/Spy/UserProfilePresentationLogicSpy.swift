@testable import Whalether
import Foundation

class UserProfilePresentationLogicSpy: UserProfilePresentationLogic {

    var invokedPresentUserProfile = false
    var invokedPresentUserProfileCount = 0
    var invokedPresentUserProfileParameters: (response: UserProfileModel.Profile.Response, Void)?
    var invokedPresentUserProfileParametersList = [(response: UserProfileModel.Profile.Response, Void)]()

    func presentUserProfile(response: UserProfileModel.Profile.Response) {
        invokedPresentUserProfile = true
        invokedPresentUserProfileCount += 1
        invokedPresentUserProfileParameters = (response, ())
        invokedPresentUserProfileParametersList.append((response, ()))
    }

    var invokedPresentChangeDisplayNameSuccess = false
    var invokedPresentChangeDisplayNameSuccessCount = 0

    func presentChangeDisplayNameSuccess() {
        invokedPresentChangeDisplayNameSuccess = true
        invokedPresentChangeDisplayNameSuccessCount += 1
    }

    var invokedPresentLogoutSuccess = false
    var invokedPresentLogoutSuccessCount = 0

    func presentLogoutSuccess() {
        invokedPresentLogoutSuccess = true
        invokedPresentLogoutSuccessCount += 1
    }

    var invokedPresentGeneralError = false
    var invokedPresentGeneralErrorCount = 0
    var invokedPresentGeneralErrorParameters: (message: String, Void)?
    var invokedPresentGeneralErrorParametersList = [(message: String, Void)]()

    func presentGeneralError(message: String) {
        invokedPresentGeneralError = true
        invokedPresentGeneralErrorCount += 1
        invokedPresentGeneralErrorParameters = (message, ())
        invokedPresentGeneralErrorParametersList.append((message, ()))
    }
}
