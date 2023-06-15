import FirebaseAuth
import UIKit

typealias LoginResult = (Result<Login.Login.Response, Login.RegisterError>) -> Void

class LoginWorker {
    func requestLogin(request: Login.Login.Request, completion: @escaping (LoginResult)) {
        Auth.auth().signIn(withEmail: request.email, password: request.password) { result, error in
            guard let result = result else {
                completion(.failure(Login.RegisterError.generalError(message: error?.localizedDescription ?? "")))
                return
            }
            let response = Login.Login.Response(uid: result.user.uid, email: result.user.email, displayName: result.user.displayName)
            completion(.success(response))
        }
    }
}
