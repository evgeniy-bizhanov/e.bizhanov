//
//  Контроллер формы регистрации
//

import Bond
import UIKit

final class RegisterViewController: UIScrollViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var content: RegisterView!
    
    // MARK: - Models
    
    // Позже переделаю, я вроде бы понял как примерно должно быть,
    // пока не успеваю сделать
    lazy var viewModel: RegisterViewModel! = try? Container.shared.resolve(service: RegisterViewModel.self)
    
    
    // MARK: - Properties
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        content.login.reactive.text ~ viewModel.login
        content.password.reactive.text ~ viewModel.password
        content.confirmPassword.reactive.text ~ viewModel.confirmPassword
        content.email.reactive.text ~ viewModel.email
        content.creditCard.reactive.text ~ viewModel.creditCard
        
        content.registerButton.reactive.isEnabled <~ viewModel.isValid
        _ = content.registerButton.reactive.tap.observeNext { [unowned self] in
            self.viewModel.register()
        }
        
        _ = content.loginButton.reactive.tap.observeNext { [unowned self] in
            self.performSegue(withIdentifier: "unwindToLogin", sender: nil)
        }
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = content.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
}
