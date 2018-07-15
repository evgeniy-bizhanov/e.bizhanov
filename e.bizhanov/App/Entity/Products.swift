import Foundation

struct Product: Codable {
    let id: Int
    let name: String
    let price: Decimal
    
    enum CodingKeys: String, CodingKey {
        case id = "id_product"
        case name = "product_name"
        case price
    }
}
