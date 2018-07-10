//
//  Profile.swift
//  e.bizhanov
//
//  Created by Евгений Бижанов on 06.07.2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import Alamofire

class Profile: BaseRequestFactory, ProfileRequestFactory {
    func changeProfile(userData: UserData, completionHandler: @escaping (DataResponse<ChangeUserDataResult>) -> Void) {
        let requestModel = Profile(baseUrl: baseUrl, userData: userData)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

// MARK: - Register request router
extension Profile {
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
