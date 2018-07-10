//
//  Catalog.swift
//  e.bizhanov
//
//  Created by Евгений Бижанов on 10.07.2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import Alamofire

class Catalog: BaseRequestFactory, CatalogRequestFactory {

    func getProducts(
        pageNumber: Int,
        filterData: FilterData,
        completionHandler: @escaping (DataResponse<[Product]>) -> Void) {
        let requestModel = ProductsRequest(baseUrl: baseUrl, pageNumber: pageNumber, filterData: filterData)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    // FIXME: API не реализовано на сервере
    func getAnotherProduct(
        productId: Int,
        completionHandler: @escaping (DataResponse<Product>) -> Void) {
        let requestModel = ProductRequest(baseUrl: baseUrl, productId: productId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

// MARK: - Products request router
extension Catalog {
    struct ProductsRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "catalogData.json"
        
        let pageNumber: Int
        let filterData: FilterData
        
        var parameters: Parameters? {
            return [
                "page_number": pageNumber,
                "id_category": filterData
            ]
        }
    }
}

// MARK: - Another product request router
extension Catalog {
    struct ProductRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        
        // FIXME: Исправить при необходимости, после того как будет реализовано API
        let path: String = "anotherProduct.json"
        
        let productId: Int
        
        var parameters: Parameters? {
            return [
                "id_product": productId
            ]
        }
    }
}
