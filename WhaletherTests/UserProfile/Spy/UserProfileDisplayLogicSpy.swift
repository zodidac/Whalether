@testable import Whalether
import Foundation

class UserProfileDisplayLogicSpy: UserProfileDisplayLogic {

    var invokedDisplayUserProfile = false
    var invokedDisplayUserProfileCount = 0
    var invokedDisplayUserProfileParameters: (viewModel: UserProfileModel.Profile.ViewModel, Void)?
    var invokedDisplayUserProfileParametersList = [(viewModel: UserProfileModel.Profile.ViewModel, Void)]()

    func displayUserProfile(viewModel: UserProfileModel.Profile.ViewModel) {
        invokedDisplayUserProfile = true
        invokedDisplayUserProfileCount += 1
        invokedDisplayUserProfileParameters = (viewModel, ())
        invokedDisplayUserProfileParametersList.append((viewModel, ()))
    }

    var invokedDisplayChangeDisplayNameSuccess = false
    var invokedDisplayChangeDisplayNameSuccessCount = 0
    var invokedDisplayChangeDisplayNameSuccessParameters: (message: String, Void)?
    var invokedDisplayChangeDisplayNameSuccessParametersList = [(message: String, Void)]()

    func displayChangeDisplayNameSuccess(message: String) {
        invokedDisplayChangeDisplayNameSuccess = true
        invokedDisplayChangeDisplayNameSuccessCount += 1
        invokedDisplayChangeDisplayNameSuccessParameters = (message, ())
        invokedDisplayChangeDisplayNameSuccessParametersList.append((message, ()))
    }

    var invokedDisplayLogoutSuccess = false
    var invokedDisplayLogoutSuccessCount = 0

    func displayLogoutSuccess() {
        invokedDisplayLogoutSuccess = true
        invokedDisplayLogoutSuccessCount += 1
    }

    var invokedDisplayGeneralError = false
    var invokedDisplayGeneralErrorCount = 0
    var invokedDisplayGeneralErrorParameters: (message: String, Void)?
    var invokedDisplayGeneralErrorParametersList = [(message: String, Void)]()

    func displayGeneralError(message: String) {
        invokedDisplayGeneralError = true
        invokedDisplayGeneralErrorCount += 1
        invokedDisplayGeneralErrorParameters = (message, ())
        invokedDisplayGeneralErrorParametersList.append((message, ()))
    }
}
