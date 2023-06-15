import UIKit

protocol LoginDisplayLogic: AnyObject {
    func displayLoginSuccess()
    func displayLoginFailed(message: String)
}

class LoginViewController: UIViewController {
    @IBOutlet private var emailTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    
    var interactor: LoginBusinessLogic?
    var router: (NSObjectProtocol & LoginRoutingLogic & LoginDataPassing)?
    
    public static func initiated() -> LoginViewController? {
        let storyboard = UIStoryboard(name: "LoginStoryboard", bundle: nil)
        guard let vc: LoginViewController = storyboard.instantiateViewController(withIdentifier: "LoginStoryboard") as? LoginViewController else { return nil }
        vc.setup()
        return vc
    }
    
    private func setup() {
        let viewController = self
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        let router = LoginRouter()
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
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func loginTapped() {
        let request = Login.Login.Request(email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
        interactor?.requestLogin(request: request)
    }
    
    @IBAction func registerTapped() {
        router?.routeToRegisterPage()
    }
}

extension LoginViewController: LoginDisplayLogic {
    func displayLoginSuccess() {
        self.dismiss(animated: true)
    }
    
    func displayLoginFailed(message: String) {
        let alert = UIAlertController(title: "Something when wrong", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel))
        self.present(alert, animated: true, completion: nil)
        
    }
}
