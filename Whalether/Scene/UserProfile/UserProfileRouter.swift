import UIKit

@objc protocol UserProfileRoutingLogic {
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol UserProfileDataPassing {
  var dataStore: UserProfileDataStore? { get }
}

class UserProfileRouter: NSObject, UserProfileRoutingLogic, UserProfileDataPassing {
  weak var viewController: UserProfileViewController?
  var dataStore: UserProfileDataStore?

}
