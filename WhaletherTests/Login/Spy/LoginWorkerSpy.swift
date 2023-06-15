@testable import Whalether

import Foundation

class LoginWorkerSpy: LoginWorker {

    var invokedRequestLogin = false
    var invokedRequestLoginCount = 0
    var invokedRequestLoginParameters: (request: Login.Login.Request, completion: (LoginResult))?
    var invokedRequestLoginParametersList = [(request: Login.Login.Request, completion: (LoginResult))]()
    var stubbedRequestLoginSuccess = true

    override func requestLogin(request: Login.Login.Request, completion: @escaping (LoginResult)) {
        invokedRequestLogin = true
        invokedRequestLoginCount += 1
        invokedRequestLoginParameters = (request, completion)
        invokedRequestLoginParametersList.append((request, completion))
        if stubbedRequestLoginSuccess {
            completion(.success(Login.Login.Response(uid: "test", email: "email", displayName: "name")))
        } else {
            completion(.failure(Login.RegisterError.generalError(message: "error")))
        }
    }
}
