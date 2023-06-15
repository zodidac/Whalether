import UIKit

enum Login
{
    // MARK: Use cases
    
    enum Login {
        struct Request {
            var email: String
            var password: String
        }
        struct Response {
            var uid: String
            var email: String?
            var displayName: String?
        }
        struct ViewModel
        {
        }
    }
    
    enum RegisterError: Error {
        case generalError(message: String)
        
        var reason: String {
            switch self {
            case let .generalError(message):
                return message
            }
        }
    }
}


