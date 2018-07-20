// Добавил для отступа, т.к. напрягает, когда первая строка упирается в край окна
import Alamofire

/**
 Контракт управления корзиной пользователя
 */
protocol BasketRequestFactory {
    typealias Completion<T> = (DataResponse<T>) -> Void
    
    /**
     Добавляет некоторое кол-во товара в корзину
     - Parameters:
        - productId: Идентификатор добавляемого продукта
        - quantity: Кол-во добавляемого продукта
     */
    func addProductToBasket(
        byId productId: Int,
        withQuantity quantity: Int,
        completionHandler: @escaping Completion<AddToBasketResult>
    )
    
    /**
     Удаляет товар из корзины
     - Parameters:
        - productId: Идентификатор удаляемого продукта
     */
    func deleteProductFromBasket(
        byId productId: Int,
        completionHandler: @escaping Completion<DeleteFromBasketResult>
    )
    
    /**
     Получает товары находящиеся в корзине пользователя
     */
    func basket(
        completionHandler: @escaping Completion<BasketResult>
    )
    
    /**
     Оплачивает товары находящиеся в корзине пользователя
     */
    func payBasket(
        completionHandler: @escaping Completion<PayBasketResult>
    )
}
