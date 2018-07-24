import Alamofire

protocol AuthRequestFactory {
    func login(
        userName: String,
        password: String,
        completionHandler: @escaping (DataResponse<LoginResult>) -> Void
    )
    
    func logout()
    
    /**
     - Parameters:
       - userData: Данные пользователя `UserData`
     */
    func register(
        userData: UserData,
        completionHandler: @escaping (DataResponse<RegisterResult>) -> Void
    )
}
