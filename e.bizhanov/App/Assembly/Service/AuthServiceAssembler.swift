//
//  Сборщики зависимостей для отдельных сервисов
//

import Alamofire
import Swinject

/// Сборщик сервиса аутентификации
class AuthServiceAssembler: Assembly {
    func assemble(container: Container) {
        
        func makeFactory<T: AbstractRequestManager>(_ service: T.Type, resolver: Resolver) -> T {
            
            let errorParser = resolver.resolve(​AbstractErrorParser​.self)
            let sessionManager = resolver.resolve(SessionManager.self)
            let sessionQueue = resolver.resolve(DispatchQueue.self)
            
            // swiftlint:disable force_unwrapping
            return T(
                errorParser: errorParser!,
                sessionManager: sessionManager!,
                queue: sessionQueue
            )
            // swiftlint:enable force_unwrapping
        }
        
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
