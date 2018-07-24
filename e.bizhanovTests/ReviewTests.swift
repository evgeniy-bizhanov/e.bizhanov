import XCTest
import OHHTTPStubs
@testable import e_bizhanov

/**
 Тестирует API получения/добавления/удаления отзывов о товаре
 */
class ReviewTests: XCTestCase {
    
    var request: ReviewsRequestFactory!
    
    override func setUp() {
        super.setUp()
        request = try! Container.shared.resolve(service: ReviewsRequestFactory.self)
    }
    
    override func tearDown() {
        super.tearDown()
        
        request = nil
        OHHTTPStubs.removeAllStubs()
    }
    
    func testReviewsShouldReturnValue() {
        HTTPStubHelper.setup(forApiMethod: "reviews.json")
        
        let exp = expectation(description: "")
        var data: Reviews?
        
        request.reviews(forProduct: 123) { result in
            data = result.value
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
        return XCTAssertNotNil(data)
    }
    
    func testAddReviewShouldReturnValue() {
        HTTPStubHelper.setup(forApiMethod: "addReview.json")
        
        let exp = expectation(description: "")
        var data: AddReviewResult?
        
        request.addReview(byUser: 123, withMessage: "Lorem ipsum", toProduct: 123) { result in
            data = result.value
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
        return XCTAssertNotNil(data)
    }
    
    func testRemoveReviewShouldReturnValue() {
        HTTPStubHelper.setup(forApiMethod: "removeReview.json")
        
        let exp = expectation(description: "")
        var data: RemoveReviewResult?
        
        request.removeReview(123) { result in
            data = result.value
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
        return XCTAssertNotNil(data)
    }
}
