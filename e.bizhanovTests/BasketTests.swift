import XCTest
import OHHTTPStubs
@testable import e_bizhanov

/**
 Тестирует АПИ работы с корзиной товаров пользователя:
  - добавление
  - удаление
  - получение списка товаров в корзине
 */
class BasketTests: XCTestCase {
    var request: BasketRequestFactory!
    
    override func setUp() {
        super.setUp()
        
        let factory = RequestFactoryMock()
        request = factory.makeBasketRequestFactory()
    }
    
    override func tearDown() {
        super.tearDown()
        
        request = nil
        OHHTTPStubs.removeAllStubs()
    }
    
    func testAddingToBasket_ShouldFail_IfQuantityLessOrEqualZero() {
        HTTPStubHelper.setup(forApiMethod: "addToBasketZero.json")
        
        let exp = expectation(description: "adding to basket")
        var response: AddingToBasketResult
        
        request.addProductToBasket(byId: 123, withQuantity: 0) { result in
            response = result.value
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
        XCTAssertEqual(response.result, 0)
    }
    
    func testAddingToBasket_ShouldReturnResult() {
        HTTPStubHelper.setup(forApiMethod: "addToBasket.json")
        
        let exp = expectation(description: "adding to basket")
        var response: AddingToBasketResult
        
        request.addProductToBasket(byId: 123, withQuantity: 1) { result in
            response = result.value
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(response)
    }
    
    func testDeletingFromBasket_ShouldReturnResult() {
        HTTPStubHelper.setup(forApiMethod: "deleteFromBasket.json")
        
        let exp = expectation(description: "deleting from basket")
        var response: DeletingFromBasketResult
        
        request.deleteProductFromBasket(byId: 123) { result in
            response = result.value
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(response)
    }
    
    func testGettingBasket_ShouldReturnResult() {
        HTTPStubHelper.setup(forApiMethod: "getBasket.json")
        
        let exp = expectation(description: "getting basket")
        var response: BasketResult
        
        request.getBasket() { result in
            response = result.value
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(response)
    }
    
    func testPayBasket_ShouldReturnResult() {
        HTTPStubHelper.setup(forApiMethod: "payBasket.json")
        
        let exp = expectation(description: "paying basket")
        var response: PayingBasketResult
        
        request.payBasket() { result in
            response = result.value
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(response)
    }
}
