import Alamofire

/**
 Управляет профилем пользователя
 */
class ProfileRequestManager: RequestManager, ProfileRequestFactory {
    
    // MARK: - Functions
    func change(
        profile: UserData,
        completionHandler: @escaping (DataResponse<ChangeUserDataResult>) -> Void) {
        let requestModel = Profile(baseUrl: baseUrl, userData: profile)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

// MARK: - Register request router
extension ProfileRequestManager {
    struct Profile: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "changeUserData.json"
        
        let userData: UserData
        
        var parameters: Parameters? {
            return [
                "username": userData.username,
                "password": userData.password,
                "email": userData.email,
                "gender": userData.gender,
                "credit_card": userData.creditCard,
                "bio": userData.bio
            ]
        }
    }
}
