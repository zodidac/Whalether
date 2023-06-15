import UIKit

@objc protocol RegisterRoutingLogic {
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol RegisterDataPassing {
  var dataStore: RegisterDataStore? { get }
}

class RegisterRouter: NSObject, RegisterRoutingLogic, RegisterDataPassing {
  weak var viewController: RegisterViewController?
  var dataStore: RegisterDataStore?
  
}
