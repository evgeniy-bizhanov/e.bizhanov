//
// Контроллер входа в приложение
//

import Bond
import UIKit

/// Контроллер входа в приложение
final class LoginViewController: UIScrollViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var content: LoginView!
    
    // MARK: - Models
    var viewModel: LoginViewModel? {
        return try? Container.shared.resolve(service: LoginViewModel.self)
    }
    
    // MARK: - Properties
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    // MARK: - IBActions
    @IBAction func unwindToLogin(sender: UIStoryboardSegue) { }
    
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let viewModel = viewModel else {
            return
        }
        
        content.login.reactive.text ~ viewModel.login
        content.password.reactive.text ~ viewModel.password
        
        content.loginButton.reactive.isEnabled <~ viewModel.isValid
        
        let loginCompletionHandler: () -> Void = { [unowned self] in
            self.performSegue(withIdentifier: "productsSegue", sender: nil)
        }
        
        _ = content.loginButton.reactive.tap.observeNext { _ in
            viewModel.enter(completionHandler: loginCompletionHandler)
        }
        
        _ = content.registerButton.reactive.tap.observeNext { [unowned self] _ in
            self.performSegue(withIdentifier: "registerSegue", sender: nil)
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = content.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
}
