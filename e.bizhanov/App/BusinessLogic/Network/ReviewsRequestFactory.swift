import Alamofire

protocol ReviewsRequestFactory {
    typealias Completion<T> = (DataResponse<T>) -> Void
    
    /**
     Получает отзывы по конкретному товару
     - Parameters:
       - productId: Идентификатор товара, по которому запрашиваются отзывы
     */
    func reviews(
        forProduct productId: Int,
        completionHandler: @escaping Completion<Reviews>
    )
    
    /**
     - Parameters:
       - userId: Идентификатор пользователя от имени которого будет добавлен отзыв
       - message: Текст отзыва о товаре
       - productId: Идентификатор товара, к которому добавляется отзыв
     */
    func addReview(
        byUser userId: Int,
        withMessage message: String,
        toProduct productId: Int,
        completionHandler: @escaping Completion<AddReviewResult>
    )
    
    /**
     - Parameters:
       - reviewId: Идентификатор отзыва, который следует удалить
     */
    func removeReview(
        _ reviewId: Int,
        completionHandler: @escaping Completion<RemoveReviewResult>
    )
}
