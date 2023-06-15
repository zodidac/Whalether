import UIKit

protocol RegisterBusinessLogic {
    func validateRegisterInfo(request: Register.Registration.Request)
}

protocol RegisterDataStore {
    
}

class RegisterInteractor: RegisterBusinessLogic, RegisterDataStore {
    var presenter: RegisterPresentationLogic?
    var worker = RegisterWorker()
    
    func validateRegisterInfo(request: Register.Registration.Request) {
        if request.email.isEmpty || request.password.isEmpty || request.rePasswrd.isEmpty {
            presenter?.presentRegisterInfoFailed(message: "Please specify information")
        } else if request.password != request.rePasswrd {
            presenter?.presentRegisterInfoFailed(message: "Password didn't match")
        } else {
            worker.registerWithFirebase(request: request) {[weak self] result in
                guard let self = self else { return }
                switch result {
                case let .success(response):
                    UserProfile.shared.setProfile(uid: response.userId, email: response.email, name: response.displayName)
                    UserProfile.shared.saveProfile()
                    self.presenter?.presentRegisterSuccess()
                case let .failure(error):
                    self.presenter?.presentRegisterInfoFailed(message: error.reason)
                }
            }
        }
    }
}
