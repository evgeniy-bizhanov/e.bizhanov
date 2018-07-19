// Добавил для отступа, т.к. напрягает, когда первая строка упирается в край окна
import Alamofire

/**
 Контракт управления корзиной пользователя
 */
protocol BasketRequestFactory {
    typealias Completion<T> = (DataResponse<T>) -> Void
    
    /**
     Добавляет неоторое кол-во товара в корзину
     - Parameters:
        - productId: Идентификатор добавляемого в корзину продукта
        - quantity: Кол-во добавляемого продукта
     */
    func addProductToBasket(
        byId productId: Int,
        withQuantity quantity: Int,
        completionHandler: @escaping Completion<AddingToBasketResult>
    )
}
