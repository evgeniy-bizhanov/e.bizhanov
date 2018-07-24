import Alamofire

/**
 Подготавливает и предоставляет реализации конкретных `request` менеджеров
 */
class RequestFactory {
    
    // MARK: - Fields
    let sessionQueue = DispatchQueue.global(qos: .utility)
    
    lazy var commonSessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        
        let manager = SessionManager(configuration: configuration)
        return manager
    }()
    
    // MARK: - Functions
    func makeErrorParser() -> ​AbstractErrorParser​ {
        return ErrorParser()
    }
    
    func makeFactory<T: AbstractRequestManager>(service: T.Type) throws -> T {
        let errorParser = try Container.shared.resolve(service: ​AbstractErrorParser​.self)
        return T(
            errorParser: errorParser,
            sessionManager: commonSessionManager,
            queue: sessionQueue
        )
    }
}
