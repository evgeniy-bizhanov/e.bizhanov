import Alamofire

class RequestManager: AbstractRequestManager {
    
    // MARK: - Properties
    let errorParser: ​AbstractErrorParser​
    let sessionManager: SessionManager
    let queue: DispatchQueue?
    
    lazy var baseUrl: URL! = {
        return URL(string: AppConfig.Network.url)
    }()

    // MARK: - Initializers
    required init (
        errorParser: ​AbstractErrorParser​,
        sessionManager: SessionManager,
        queue: DispatchQueue? = DispatchQueue.global(qos: .utility)) {
        
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}
