//
//  Подготовка фабрики к внедрению
//

import Alamofire
import Swinject

// Хотел сделать через миксины, но swinject удаляет ссылки на сборщики
// и self оказывается nil
//
// Так же хотел сделать через замыкание типа (Resolver) -> Service,
// но не понял как пробросить генерик Service в метод регистрации
//
// В итоге сделал через хелпер

/// Хелпер для подготовки объектов внедрения
class Injector {
    
    /**
     Создает сервисы по их типам
     
     - Parameters:
       - service: Тип сервиса, которых необходимо создать
       - resolver: Контейнер разрешения зависимостей
     */
    static func makeFactory<T: AbstractRequestManager>(_ service: T.Type, resolver: Resolver) -> T {
        
        let errorParser = resolver.resolve(​AbstractErrorParser​.self)
        let sessionManager = resolver.resolve(SessionManager.self)
        let sessionQueue = resolver.resolve(DispatchQueue.self)
        
        // Странненько реализован Swinject
        // Сам в resolve возвращает optional, но моя фабрика при этом optional возвращать не может
        // Предпочтительнее было бы так конечно:
        //        guard
        //            let errorParser = resolver.resolve(​AbstractErrorParser​.self),
        //            let sessionManager = resolver.resolve(SessionManager.self),
        //            let sessionQueue = resolver.resolve(DispatchQueue.self) else {
        //
        //                assertionFailure("Зависимости не зарегистрированы")
        //                return nil
        //        }
        
        // swiftlint:disable force_unwrapping
        return T(
            errorParser: errorParser!,
            sessionManager: sessionManager!,
            queue: sessionQueue
        )
        // swiftlint:enable force_unwrapping
    }
    
    /// Создает и конфигурирует менеджер сессий
    static func makeSessionManager() -> SessionManager {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        
        let manager = SessionManager(configuration: configuration)
        return manager
    }
}
