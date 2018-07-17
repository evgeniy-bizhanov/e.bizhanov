import Alamofire
import OHHTTPStubs
@testable import e_bizhanov

/**
 Подготавливает и предоставляет реализации конкретных `request` менеджеров
 */
class RequestFactoryMock {
    
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
        return ErrorParserStub()
    }
}

// MARK: - Auth manager
extension RequestFactoryMock {
    func makeAuthRequestFactory<T>() -> T! {
        let errorParser = makeErrorParser()
        return AuthRequestManager(
            errorParser: errorParser,
            sessionManager: commonSessionManager,
            queue: sessionQueue) as? T
    }
}

// MARK: - Profile manager
extension RequestFactoryMock {
    func makeProfileRequestFactory<T>() -> T! {
        let errorParser = makeErrorParser()
        return ProfileRequestManager(
            errorParser: errorParser,
            sessionManager: commonSessionManager,
            queue: sessionQueue) as? T
    }
}

// MARK: - Catalog manager
extension RequestFactoryMock {
    func makeCatalogRequestFactory<T>() -> T! {
        let errorParser = makeErrorParser()
        return CatalogRequestManager(
            errorParser: errorParser,
            sessionManager: commonSessionManager,
            queue: sessionQueue) as? T
    }
}

// MARK: - Catalog manager
extension RequestFactoryMock {
    func makeReviewsRequestFactory<T>() -> T! {
        let errorParser = makeErrorParser()
        return ReviewsRequestManager(
            errorParser: errorParser,
            sessionManager: commonSessionManager,
            queue: sessionQueue) as? T
    }
}
