import UIKit

protocol UserProfileBusinessLogic {
    func requestUserProfile()
    func requestChangeDisplayName(request: UserProfileModel.ChangeDisplayName.Request)
    func logout()
}

protocol UserProfileDataStore {
    
}

class UserProfileInteractor: UserProfileBusinessLogic, UserProfileDataStore {
    var presenter: UserProfilePresentationLogic?
    var worker = UserProfileWorker()
        
    func requestUserProfile() {
        guard let profile = UserProfile.shared.getProfile() else { return }
        presenter?.presentUserProfile(response: UserProfileModel.Profile.Response(email: profile.email ?? "", displayName: profile.name ?? ""))
    }
    
    func requestChangeDisplayName(request: UserProfileModel.ChangeDisplayName.Request) {
        worker.changeDisplayName(request: request, completion: {[weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                self.presenter?.presentChangeDisplayNameSuccess()
            case let .failure(error):
                self.presenter?.presentGeneralError(message: error.reason)
            }
        })
    }
    
    func logout() {
        UserProfile.shared.clearProfile()
        presenter?.presentLogoutSuccess()
    }
}
