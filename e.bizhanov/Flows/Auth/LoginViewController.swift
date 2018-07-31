//
// Контроллер входа в приложение
//

import Bond
import UIKit

/// Контроллер входа в приложение
final class LoginViewController: UIScrollViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var contentView: LoginView!
    
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
        
        contentView.login.reactive.text ~ viewModel.login
        contentView.password.reactive.text ~ viewModel.password
        
        contentView.loginButton.reactive.isEnabled <~ viewModel.isValid
        
        _ = contentView.loginButton.reactive.tap.observeNext { _ in
            viewModel.enter()
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = contentView.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
}
