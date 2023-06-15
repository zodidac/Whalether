import FirebaseAuth
import UIKit

typealias ResgisterResult = (Result<Register.Registration.Response, Register.RegisterError>) -> Void

class RegisterWorker {
    func registerWithFirebase(request: Register.Registration.Request, completion: @escaping (ResgisterResult)) {
        Auth.auth().createUser(withEmail: request.email, password: request.password) { result, error in
            guard let result = result else {
                completion(.failure(Register.RegisterError.userDuplicated(message: error?.localizedDescription ?? "")))
                return
            }
            let response = Register.Registration.Response(userId: result.user.uid, email: result.user.email, displayName: result.user.displayName)
            completion(.success(response))
        }
    }
}
