//
//  Auth.swift
//  e.bizhanov
//
//  Created by Евгений Бижанов on 05.07.2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import Alamofire

class Auth: AbstractRequestFactory {
    let errorParser: ​AbstractErrorParser​
    let sessionManager: SessionManager
    let queue: DispatchQueue?
    let baseUrl: URL! = URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")
    
    init (
        errorParser: ​AbstractErrorParser​,
        sessionManager: SessionManager,
        queue: DispatchQueue? = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension Auth: AuthRequestFactory {
    func login(userName: String, password: String, completionHandler: @escaping (DataResponse<LoginResult>) -> Void) {
        let requestModel = Login(baseUrl: baseUrl, login: userName, password: password)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func logout(completionHandler: @escaping (DataResponse<LogoutResult>) -> Void) {
        let requestModel = Logout(baseUrl: baseUrl)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension Auth: RegisterRequestFactory {
    func register(userInfo: RegisterUser, completionHandler: @escaping (DataResponse<RegisterResult>) -> Void) {
        let requestModel = Register(baseUrl: baseUrl, registerInfo: userInfo)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

//- MARK: Login request router
extension Auth {
    struct Login: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "login.json"
        
        let login: String
        let password: String
        
        var parameters: Parameters? {
            return [
                "username": login,
                "password": password
            ]
        }
    }
}

//- MARK: Register request router
extension Auth {
    struct Register: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "registerUser.json"
        
        let registerInfo: RegisterUser
        
        var parameters: Parameters? {
            return [
                "username": registerInfo.username,
                "password": registerInfo.password,
                "email": registerInfo.email,
                "gender": registerInfo.gender,
                "credit_card": registerInfo.creditCard,
                "bio": registerInfo.bio
            ]
        }
    }
}

//- MARK: Logout request router
extension Auth {
    struct Logout: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "logout.json"
        
        var parameters: Parameters? {
            return nil
        }
    }
}
