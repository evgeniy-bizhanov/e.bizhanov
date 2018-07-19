import Alamofire

/**
 Позволяет работать с отзывами пользователя, добавлять, удалять и получать их
 */
class ReviewsRequestManager: RequestManager, ReviewsRequestFactory {
    func reviews(
        forProduct productId: Int,
        completionHandler: @escaping (DataResponse<Reviews>) -> Void) {
        let requestModel = ReviewsRequest(baseUrl: baseUrl, productId: productId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func addReview(
        byUser userId: Int,
        withMessage message: String,
        toProduct productId: Int,
        completionHandler: @escaping (DataResponse<AddReviewResult>) -> Void) {
        let requestModel = AddReviewRequest(baseUrl: baseUrl, userId: userId, productId: productId, message: message)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func removeReview(
        _ reviewId: Int,
        completionHandler: @escaping (DataResponse<RemoveReviewResult>) -> Void) {
        let requestModel = RemoveReviewRequest(baseUrl: baseUrl, reviewId: reviewId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

// MARK: - Get product reviews
extension ReviewsRequestManager {
    struct ReviewsRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "reviews.json"
        
        let productId: Int
        
        var parameters: Parameters? {
            return [
                "id_product": productId
            ]
        }
    }
}

// MARK: - Add review to product
extension ReviewsRequestManager {
    struct AddReviewRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "addReview.json"
        
        let userId: Int
        let productId: Int
        let message: String
        
        var parameters: Parameters? {
            return [
                "id_user": userId,
                "id_product": productId,
                "text": message
            ]
        }
    }
}

// MARK: - Remove review to product
extension ReviewsRequestManager {
    struct RemoveReviewRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "removeReview.json"
        
        let reviewId: Int
        
        var parameters: Parameters? {
            return [
                "id_comment": reviewId
            ]
        }
    }
}
