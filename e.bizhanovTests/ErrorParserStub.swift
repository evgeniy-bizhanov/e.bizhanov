import Alamofire
@testable import e_bizhanov

enum ApiErrorStub: Error {
    case fatalError
}

class ErrorParserStub: ​AbstractErrorParser​ {
    func parse(_ result: Error) -> Error {
        return ApiErrorStub.fatalError
    }
    
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error? {
        return error
    }
}
