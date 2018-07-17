import Alamofire

protocol ProfileRequestFactory {
    
    /**
     - Parameters:
       - userData: Данные пользователя `UserData`
     */
    func change(
        profile: UserData,
        completionHandler: @escaping (DataResponse<ChangeUserDataResult>) -> Void
    )
    
}
