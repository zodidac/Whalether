import UIKit

protocol LoginBusinessLogic {
    func requestLogin(request: Login.Login.Request)
}

protocol LoginDataStore {
    
}

class LoginInteractor: LoginBusinessLogic, LoginDataStore {
    var presenter: LoginPresentationLogic?
    var worker = LoginWorker()
    
    func requestLogin(request: Login.Login.Request) {
        worker.requestLogin(request: request) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                UserProfile.shared.setProfile(uid: response.uid, email: response.email, name: response.displayName)
                self.presenter?.presentLoginSuccess()
            case let .failure(error):
                self.presenter?.presentLoginFailed(message: error.reason)
            }
        }
    }
}
