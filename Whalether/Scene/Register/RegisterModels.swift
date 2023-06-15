import UIKit

enum Register {
    // MARK: Use cases
    
    enum Registration {
        struct Request{
            var email: String
            var password: String
            var rePasswrd: String
        }
        struct Response {
            var userId: String
            var email: String?
            var displayName: String?
        }
    }
    
    enum RegisterError: Error {
      case userDuplicated(message: String)

      var reason: String {
        switch self {
        case let .userDuplicated(message):
          return message
        }
      }
    }
}
