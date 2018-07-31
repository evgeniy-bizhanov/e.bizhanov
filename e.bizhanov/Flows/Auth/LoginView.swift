import Bond
import Swinject
import UIKit

/// Форма входа в приложение
final class LoginView: UINibView {
    // MARK: - IBOutlets
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
}
