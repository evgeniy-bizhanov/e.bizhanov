import Alamofire

protocol CatalogRequestFactory {
    
    /**
     Постраничное получение списка товаров
     - Parameters:
       - pageNumber: Страница с товарами, которую необходимо запросить
       - filterData: Настраиваемый фильтр для отправки на сервер `FilterData`
     */
    func products(
        fromPage page: Int,
        withFilter filter: FilterData,
        completionHandler: @escaping (DataResponse<[Product]>) -> Void
    )
    
    /**
     Получает товар с сервера по его Id
     - Parameters:
       - productId: Данные пользователя `UserData`
     */
    func product(
        withId id: Int,
        completionHandler: @escaping (DataResponse<Product>) -> Void
    )
}
