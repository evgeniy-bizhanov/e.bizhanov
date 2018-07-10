//
//  ProductTest.swift
//  e.bizhanovTests
//
//  Created by Евгений Бижанов on 09.07.2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import XCTest
import OHHTTPStubs
@testable import e_bizhanov

class CatalogTests: XCTestCase {
    var request: CatalogRequestFactory!
    
    override func setUp() {
        super.setUp()
        
        let requestFactory = RequestFactoryMock()
        request = requestFactory.makeCatalogRequestFactory()
    }
    
    override func tearDown() {
        super.tearDown()
        
        request = nil
        OHHTTPStubs.removeAllStubs()
    }
    
    func testGetProductsShouldReturnValue() {
        let exp = expectation(description: "")
        
        // Пока не придумал куда спрятать имя метода.
        // По хорошему как на уроке было сказано в модели хранить некоторые данные для
        // тестов.
        // Но так же не понятно, либо экземпляр тогда придется передавать,
        // либо переменные класса делать (в интерфейсе такие сделать вроде бы нельзя),
        // но тогда их придется делать
        // В общем есть над чем подумать:)
        HTTPStubHelper.setup(forApiMethod: "catalogData.json")
        
        let filter = FilterData(categoryId: 1)
        var data: [Product]?
        request.getProducts(pageNumber: 1, filterData: filter) { result in
            data = result.value
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(data)
    }
    
    func testGetAnotherProductShouldReturnValue() {
        let exp = expectation(description: "")
        HTTPStubHelper.setup(forApiMethod: "anotherProduct.json")
        
        var data: Product?
        request.getAnotherProduct(productId: 123) { result in
            data = result.value
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(data)
    }
}
