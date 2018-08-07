//
//  Внедряет зависимости в контроллеры авторизации
//

import Swinject

// MARK: - Вход
class LoginBuilder: AbstractModuleBuilder {
    @IBOutlet weak var vc: LoginViewController!
    
    override func resolve(resolver: Resolver) {
        vc.viewModel = resolver.resolve(LoginViewModel.self)
    }
}

// MARK: - Регистрация
class RegisterBuilder: AbstractModuleBuilder {
    @IBOutlet weak var vc: RegisterViewController!
    
    override func resolve(resolver: Resolver) {
        vc.viewModel = resolver.resolve(RegisterViewModel.self)
    }
}
