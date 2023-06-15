@testable import Whalether

import Foundation

class UserProfileWorkerSpy: UserProfileWorker {

    var invokedChangeDisplayName = false
    var invokedChangeDisplayNameCount = 0
    var invokedChangeDisplayNameParameters: (request: UserProfileModel.ChangeDisplayName.Request, Void)?
    var invokedChangeDisplayNameParametersList = [(request: UserProfileModel.ChangeDisplayName.Request, Void)]()
    var stubbedChangeDisplayNameCompletionResult: (Result<Bool, Login.RegisterError>, Void)?

    override func changeDisplayName(request: UserProfileModel.ChangeDisplayName.Request, completion: @escaping ChangeDisplayNameResult) {
        invokedChangeDisplayName = true
        invokedChangeDisplayNameCount += 1
        invokedChangeDisplayNameParameters = (request, ())
        invokedChangeDisplayNameParametersList.append((request, ()))
        if let result = stubbedChangeDisplayNameCompletionResult {
            completion(result.0)
        }
    }
}
