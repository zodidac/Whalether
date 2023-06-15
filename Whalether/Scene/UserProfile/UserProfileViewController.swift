
import UIKit

protocol UserProfileDisplayLogic: AnyObject {
    func displayUserProfile(viewModel: UserProfileModel.Profile.ViewModel)
    func displayChangeDisplayNameSuccess(message: String)
    func displayLogoutSuccess()
    func displayGeneralError(message: String)
}

class UserProfileViewController: UIViewController {
    @IBOutlet private var emailLabel: UILabel!
    @IBOutlet private var displayNameTextField: UITextField!
    
    var interactor: UserProfileBusinessLogic?
    var router: (NSObjectProtocol & UserProfileRoutingLogic & UserProfileDataPassing)?
    
    public static func initiated() -> UserProfileViewController? {
        let storyboard = UIStoryboard(name: "UserProfileStoryboard", bundle: nil)
        guard let vc: UserProfileViewController = storyboard.instantiateViewController(withIdentifier: "UserProfileStoryboard") as? UserProfileViewController else { return nil }
        vc.setup()
        return vc
    }

    
    private func setup() {
        let viewController = self
        let interactor = UserProfileInteractor()
        let presenter = UserProfilePresenter()
        let router = UserProfileRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayNameTextField.delegate = self
        interactor?.requestUserProfile()
    }
    
    @IBAction func saveTapped() {
        let request = UserProfileModel.ChangeDisplayName.Request(displayName: displayNameTextField.text ?? "")
        interactor?.requestChangeDisplayName(request: request)
    }
    
    @IBAction func logoutTapped() {
        interactor?.logout()
    }
}

extension UserProfileViewController: UserProfileDisplayLogic {
    func displayUserProfile(viewModel: UserProfileModel.Profile.ViewModel) {
        emailLabel.text = viewModel.email
        displayNameTextField.text = viewModel.displayName
    }
    
    func displayChangeDisplayNameSuccess(message: String) {
        let alert = UIAlertController(title: "Success", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel))
        self.present(alert, animated: true, completion: nil)
    }
    
    func displayLogoutSuccess() {
        self.dismiss(animated: true)
    }
    
    func displayGeneralError(message: String) {
        let alert = UIAlertController(title: "Something when wrong", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel))
        self.present(alert, animated: true, completion: nil)
    }
}

extension UserProfileViewController: UITextFieldDelegate {
    
}
