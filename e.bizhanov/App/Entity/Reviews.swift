// MARK: - Reviews
struct Reviews: Codable {
    let productId: Int
    let reviews: [Review]
    
    enum CodingKeys: String, CodingKey {
        case productId = "id_product"
        case reviews
    }
}

struct Review: Codable {
    let userId: Int
    let reviewId: Int
    let text: String
    
    enum CodingKeys: String, CodingKey {
        case userId = "id_user"
        case reviewId = "id_comment"
        case text
    }
}

// MARK: - Add review
struct AddReviewResult: Codable {
    let result: Int
    let userMessage: String
}

// MARK: - Remove review
struct RemoveReviewResult: Codable {
    let result: Int
    let userMessage: String
}
