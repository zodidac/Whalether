@testable import Whalether
import Foundation

class RegisterWorkerSpy: RegisterWorker {

    var invokedRegisterWithFirebase = false
    var invokedRegisterWithFirebaseCount = 0
    var invokedRegisterWithFirebaseParameters: (request: Register.Registration.Request, completion: (ResgisterResult))?
    var invokedRegisterWithFirebaseParametersList = [(request: Register.Registration.Request, completion: (ResgisterResult))]()
    var stubbedRegisterSuccess = true

    override func registerWithFirebase(request: Register.Registration.Request, completion: @escaping (ResgisterResult)) {
        invokedRegisterWithFirebase = true
        invokedRegisterWithFirebaseCount += 1
        invokedRegisterWithFirebaseParameters = (request, completion)
        invokedRegisterWithFirebaseParametersList.append((request, completion))
        if stubbedRegisterSuccess {
            completion(.success(Register.Registration.Response(userId: "1234", email: "1234", displayName: nil)))
        } else {
            completion(.failure(Register.RegisterError.userDuplicated(message: "error")))
        }
    }
}
