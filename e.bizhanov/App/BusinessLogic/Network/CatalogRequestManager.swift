import Alamofire

/**
 Позволяет работать с каталогом магазина
 */
class CatalogRequestManager: RequestManager, CatalogRequestFactory {

    // MARK: - Functions
    func products(
        fromPage page: Int,
        withFilter filter: FilterData,
        completionHandler: @escaping (DataResponse<[Product]>) -> Void) {
        
        let requestModel = ProductsRequest(baseUrl: baseUrl, pageNumber: page, filterData: filter)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func product(
        withId id: Int,
        completionHandler: @escaping (DataResponse<Product>) -> Void) {
        
        let requestModel = ProductRequest(baseUrl: baseUrl, productId: id)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

// MARK: - Products request router
extension CatalogRequestManager {
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
extension CatalogRequestManager {
    struct ProductRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        
        let path: String = "anotherProduct.json"
        
        let productId: Int
        
        var parameters: Parameters? {
            return [
                "id_product": productId
            ]
        }
    }
}
