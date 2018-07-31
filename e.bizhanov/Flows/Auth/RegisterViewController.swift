//
//  Контроллер формы регистрации
//

import UIKit

class RegisterViewController: UIScrollViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var content: RegisterView!
    
    
    // MARK: - Models
    
    var viewModel: RegisterViewModel? {
        // Позже переделаю, я понял как примерно должно быть,
        // пока не успеваю сделать
        return try? Container.shared.resolve(service: RegisterViewModel.self)
    }
    
    
    // MARK: - Properties
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let viewModel = viewModel else {
            return
        }
        
        content.login.reactive.text ~ viewModel.login
        content.password.reactive.text ~ viewModel.password
        content.email.reactive.text ~ viewModel.email
        content.creditCard.reactive.text ~ viewModel.creditCard
        
        content.registerButton.reactive.isEnabled <~ viewModel.isValid
    }
}
