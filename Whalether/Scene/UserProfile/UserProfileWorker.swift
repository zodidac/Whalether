import FirebaseAuth
import UIKit

typealias ChangeDisplayNameResult = (Result<Bool, Login.RegisterError>) -> Void

class UserProfileWorker {
    func changeDisplayName(request: UserProfileModel.ChangeDisplayName.Request, completion: @escaping ChangeDisplayNameResult) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = request.displayName
        changeRequest?.commitChanges(completion: { error in
            guard let erorr = error else {
                UserProfile.shared.setDisplayName(displayName: Auth.auth().currentUser?.displayName ?? "")
                completion(.success(true ))
                return
            }
            completion(.failure(Login.RegisterError.generalError(message: error?.localizedDescription ?? "")))
        })
    }
}
