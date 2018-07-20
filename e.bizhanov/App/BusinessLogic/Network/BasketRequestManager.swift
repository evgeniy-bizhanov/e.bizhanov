//
import Alamofire

/**
 Позволяет работать с корзиной пользователя, добавлять товары, удалять и оплачивать их
 */
class BasketRequestManager: RequestManager, BasketRequestFactory {
    func addProductToBasket(
        byId productId: Int,
        withQuantity quantity: Int,
        completionHandler: @escaping Completion<AddToBasketResult>) {
        
        let request = AddToBasketRequest(
            baseUrl: baseUrl,
            productId: productId,
            quantity: quantity
        )
        
        self.request(request: request, completionHandler: completionHandler)
    }
    
    func deleteProductFromBasket(
        byId productId: Int,
        completionHandler: @escaping Completion<DeleteFromBasketResult>) {
        
        let request = DeleteFromBasketRequest(
            baseUrl: baseUrl,
            productId: productId
        )
        
        self.request(request: request, completionHandler: completionHandler)
    }
    
    func basket(
        completionHandler: @escaping Completion<BasketResult>) {
        
        let request = GetBasketRequest(baseUrl: baseUrl)
        self.request(request: request, completionHandler: completionHandler)
    }
    
    func payBasket(
        completionHandler: @escaping Completion<PayBasketResult>) {
        
        let request = PayBasketRequest(baseUrl: baseUrl)
        self.request(request: request, completionHandler: completionHandler)
    }
}

// MARK: - Adding product router
extension BasketRequestManager {
    struct AddToBasketRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "addToBasket.json"
        
        let productId: Int
        let quantity: Int
        
        var parameters: Parameters? {
            return [
                "id_product": productId,
                "quantity": quantity
            ]
        }
    }
}

// MARK: - Deleting product router
extension BasketRequestManager {
    struct DeleteFromBasketRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "deleteFromBasket.json"
        
        let productId: Int
        
        var parameters: Parameters? {
            return [
                "id_product": productId
            ]
        }
    }
}

// MARK: - Getting product router
extension BasketRequestManager {
    struct GetBasketRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "getBasket.json"
        
        var parameters: Parameters? {
            return nil
        }
    }
}

// MARK: - Paying product router
extension BasketRequestManager {
    struct PayBasketRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "payBasket.json"
        
        var parameters: Parameters? {
            return nil
        }
    }
}
