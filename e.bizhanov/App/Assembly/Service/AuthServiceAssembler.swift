//
//  Сборщики зависимостей для отдельных сервисов
//

import Alamofire
import Swinject

/// Сборщик сервиса аутентификации
class AuthServiceAssembler: Assembly {
    func assemble(container: Container) {
        
        container.register(AuthRequestFactory.self) { resolver in
            Injector.makeFactory(AuthRequestManager.self, resolver: resolver)
        }
        
        container.register(LoginViewModel.self) { resolver in
            let auth: AuthRequestFactory! = resolver.resolve(AuthRequestFactory.self)
            return LoginViewModel(service: auth)
        }
        
        container.register(RegisterViewModel.self) { resolver in
            let auth: AuthRequestFactory! = resolver.resolve(AuthRequestFactory.self)
            return RegisterViewModel(service: auth)
        }
    }
}
