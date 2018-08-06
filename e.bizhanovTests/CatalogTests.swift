import XCTest
import OHHTTPStubs
@testable import e_bizhanov

class CatalogTests: XCTestCase {
    
    var request: CatalogRequestFactory!
    
    override func setUp() {
        super.setUp()
        request = resolver.resolve(CatalogRequestFactory.self)
    }
    
    override func tearDown() {
        super.tearDown()
        
        request = nil
        OHHTTPStubs.removeAllStubs()
    }
    
    func testProductsShouldReturnValue() {
        let exp = expectation(description: "")
        
        HTTPStubHelper.setup(forApiMethod: "catalogData.json")
        
        let filter = FilterData(categoryId: 1)
        var data: [Product]?
        request.products(fromPage: 1, withFilter: filter) { result in
            data = result.value
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(data)
    }
    
    func testProductByIdShouldReturnValue() {
        let exp = expectation(description: "")
        HTTPStubHelper.setup(forApiMethod: "anotherProduct.json")
        
        var data: Product?
        request.product(withId: 123) { result in
            data = result.value
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(data)
    }
}
