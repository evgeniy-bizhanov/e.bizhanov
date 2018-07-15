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
}

// MARK: - Auth manager
extension RequestFactory {
    func makeAuthRequestFactory<T>() -> T! {
        let errorParser = makeErrorParser()
        return AuthRequestManager(
            errorParser: errorParser,
            sessionManager: commonSessionManager,
            queue: sessionQueue) as? T
    }
}

// MARK: - Profile manager
extension RequestFactory {
    func makeProfileRequestFactory<T>() -> T! {
        let errorParser = makeErrorParser()
        return ProfileRequestManager(
            errorParser: errorParser,
            sessionManager: commonSessionManager,
            queue: sessionQueue) as? T
    }
}

// MARK: - Catalog manager
extension RequestFactory {
    func makeCatalogRequestFactory<T>() -> T! {
        let errorParser = makeErrorParser()
        return CatalogRequestManager(
            errorParser: errorParser,
            sessionManager: commonSessionManager,
            queue: sessionQueue) as? T
    }
}
