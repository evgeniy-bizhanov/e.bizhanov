//
// Описание сущностей, используемых при работе с корзиной пользователя
//

import Foundation

// MARK: - Adding
/// Результат добавления товара в корзину
struct AddingToBasketResult: Codable {
    let result: Int
}

// MARK: - Deleting
/// Результат удаления товара из корзины
struct DeletingFromBasketResult: Codable {
    let result: Int
}

// MARK: - Getting
/// Получение содержимого корзины пользователя
struct BasketResult: Codable {
    let amount: Decimal
    let countGoods: Int
    let contents: [BasketItem]
}

/// Элемент корзины пользователя
struct BasketItem: Codable {
    let productId: Int
    let productName: String
    let price: Decimal
    let quantity: Int
    
    enum CodingKeys: String, CodingKey {
        case productId = "id_product"
        case productName = "product_name"
        case price
        case quantity
    }
}

// MARK: - Paying
/// Результат оплаты корзины пользователя
struct PayingBasketResult: Codable {
    let result: Int
    let userMessage: String
}
