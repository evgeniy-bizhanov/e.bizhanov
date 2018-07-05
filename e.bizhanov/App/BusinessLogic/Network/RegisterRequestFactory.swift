//
//  RegisterRequestFactory.swift
//  e.bizhanov
//
//  Created by Евгений Бижанов on 05.07.2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import Alamofire

protocol RegisterRequestFactory: BaseFactory {
    
    /**
     Выполняет регистрацию пользователя
     - Parameters:
     - userInfo: Информация о пользователе `RegisterUser`
     */
    func register(userInfo: RegisterUser,
                  completionHandler: @escaping (DataResponse<RegisterResult>) -> Void)
    
}
