//
//  Настройка зависимостей
//

import Alamofire

extension AppDelegate {
    /// Подготавливает контейнер зависимостей
    func setupDIContainer() {
        
        // MARK: - Functions
        func makeFactory<T: AbstractRequestManager>(_ service: T.Type, resolver: Resolver) -> T {
            
            // Можно было использовать синглтон, но не уверен что в принципе нужно было делать
            // контейнер как синглтон.
            
            // swiftlint:disable force_try
            let errorParser = try! resolver.resolve(service: ​AbstractErrorParser​.self)
            let sessionManager = try! resolver.resolve(service: SessionManager.self)
            let sessionQueue = try! resolver.resolve(service: DispatchQueue.self)
            // swiftlint:enable force_try
            
            return T(
                errorParser: errorParser,
                sessionManager: sessionManager,
                queue: sessionQueue
            )
        }
        
        func prepareSessionManager() -> SessionManager {
            let configuration = URLSessionConfiguration.default
            configuration.httpShouldSetCookies = false
            configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
            
            let manager = SessionManager(configuration: configuration)
            return manager
        }
        
        // MARK: - Prepare dependencies
        Container.shared.register(DispatchQueue.self) { _ in
            DispatchQueue.global(qos: .utility)
        }
        
        Container.shared
            .register(SessionManager.self) { _ in
                prepareSessionManager()
            }.inScope(.singleton)
        
        Container.shared.register(​AbstractErrorParser​.self) { _ in
            ErrorParser()
        }
        
        // MARK: - Factories
        Container.shared.register(CatalogRequestFactory.self) { resolver in
            makeFactory(CatalogRequestManager.self, resolver: resolver)
        }
        
        Container.shared.register(ReviewsRequestFactory.self) { resolver in
            makeFactory(ReviewsRequestManager.self, resolver: resolver)
        }
        
        Container.shared.register(BasketRequestFactory.self) { resolver in
            makeFactory(BasketRequestManager.self, resolver: resolver)
        }
        
        // MARK: - Auth
        Container.shared.register(AuthRequestFactory.self) { resolver in
            makeFactory(AuthRequestManager.self, resolver: resolver)
        }
        
        Container.shared.register(LoginViewModel.self) { resolver in
            LoginViewModel(service: try resolver.resolve(service: AuthRequestFactory.self))
        }
    }
}
