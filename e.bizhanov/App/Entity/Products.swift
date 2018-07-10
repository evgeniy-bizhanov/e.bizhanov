//
//  Products.swift
//  e.bizhanov
//
//  Created by Евгений Бижанов on 09.07.2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import Foundation

//struct ProductsResult: Codable {
//    let pageNumber: Int
//    let products: [Product]
//    
//    enum CodingKeys: String, CodingKey {
//        case pageNumber = "page_number"
//        case products
//    }
//}

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
