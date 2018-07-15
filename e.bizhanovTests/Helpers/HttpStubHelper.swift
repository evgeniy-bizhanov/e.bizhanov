import OHHTTPStubs

class HTTPStubHelper {
    class func setup(forApiMethod methodName: String) {
        stub(condition: isMethodGET() && pathEndsWith(methodName)) { request in
            let fileUrl = Bundle.main.url(forResource: methodName, withExtension: "stub")!
            return OHHTTPStubsResponse(
                fileURL: fileUrl,
                statusCode: 200,
                headers: nil
            )
        }
    }
    
    private init(){}
}
