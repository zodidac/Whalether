import UIKit

protocol UserProfilePresentationLogic {
    func presentUserProfile(response: UserProfileModel.Profile.Response)
    func presentChangeDisplayNameSuccess()
    func presentLogoutSuccess()
    func presentGeneralError(message: String)
}

class UserProfilePresenter: UserProfilePresentationLogic {
    weak var viewController: UserProfileDisplayLogic?
    
    func presentUserProfile(response: UserProfileModel.Profile.Response) {
        let viewModel =  UserProfileModel.Profile.ViewModel(email: response.email, displayName: response.displayName)
        viewController?.displayUserProfile(viewModel: viewModel)
    }
    
    func presentChangeDisplayNameSuccess() {
        viewController?.displayChangeDisplayNameSuccess(message: "Change display name success")
    }
    
    func presentLogoutSuccess() {
        viewController?.displayLogoutSuccess()
    }
    
    func presentGeneralError(message: String) {
        viewController?.displayGeneralError(message: message)
    }
}
