//
//  Описание общих зависимостей
//

import Alamofire
import Swinject

/// Сборщик зависимостей
class ServiceAssembler: Assembly {
    func assemble(container: Container) {
        
        container.register(DispatchQueue.self) { _ in
            DispatchQueue.global(qos: .utility)
        }
        
        container.register(SessionManager.self) { _ in
            Injector.makeSessionManager()
        }.inObjectScope(.container)
        
        container.register(​AbstractErrorParser​.self) { _ in
            ErrorParser()
        }
    }
}
