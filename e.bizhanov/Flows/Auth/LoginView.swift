import Bond
import Swinject
import UIKit

/// Форма входа в приложение
final class LoginView: UINibView {
    // MARK: - IBOutlets
    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
}
