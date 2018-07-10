//
//  ProfileRequestFactory.swift
//  e.bizhanov
//
//  Created by Евгений Бижанов on 06.07.2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import Alamofire

protocol CatalogRequestFactory {
    
    /**
     Постранично получает список товаров на сервере
     - Parameters:
       - pageNumber: Страница с товарами, которую необходимо запросить
       - filterData: Настраиваемый фильтр для отправки на сервер `FilterData`
     */
    func getProducts(
        pageNumber: Int,
        filterData: FilterData,
        completionHandler: @escaping (DataResponse<[Product]>) -> Void
    )
    
    /**
     Получает товар с сервера по его Id
     - Parameters:
       - productId: Данные пользователя `UserData`
     */
    func getAnotherProduct(
        productId: Int,
        completionHandler: @escaping (DataResponse<Product>) -> Void
    )
}
