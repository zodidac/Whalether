import UIKit

protocol RegisterDisplayLogic: AnyObject {
    func displayRegisterInfoFailed(message: String)
    func displayRegisterSuccess()
}

class RegisterViewController: UIViewController {
    @IBOutlet private var emailTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var rePasswordTextField: UITextField!
    var interactor: RegisterBusinessLogic?
    var router: (NSObjectProtocol & RegisterRoutingLogic & RegisterDataPassing)?
    
    public static func initiated() -> RegisterViewController? {
        let storyboard = UIStoryboard(name: "RegisterViewControllerStoryboard", bundle: nil)
        guard let vc: RegisterViewController = storyboard.instantiateViewController(withIdentifier: "RegisterViewControllerStoryboard") as? RegisterViewController else { return nil }
        vc.setup()
        return vc
    }
    
    private func setup() {
        let viewController = self
        let interactor = RegisterInteractor()
        let presenter = RegisterPresenter()
        let router = RegisterRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func registerTapped() {
        let request = Register.Registration.Request(email: emailTextField.text ?? "", password: passwordTextField.text ?? "", rePasswrd: rePasswordTextField.text ?? "")
        interactor?.validateRegisterInfo(request: request)
    }
    
    @IBAction func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension RegisterViewController: RegisterDisplayLogic {
    func displayRegisterInfoFailed(message: String) {
        let alert = UIAlertController(title: "Something when wrong", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel))
        self.present(alert, animated: true, completion: nil)
    }
    
    func displayRegisterSuccess() {
        self.dismiss(animated: true)
    }
}
