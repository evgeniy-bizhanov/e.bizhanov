//
//  AuthRequestFactory.swift
//  e.bizhanov
//
//  Created by Евгений Бижанов on 05.07.2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import Alamofire

protocol AuthRequestFactory {
    
    /**
     Выполняет авторизацию пользователя
     - Parameters:
       - userName: Имя пользователя
       - password: Пароль пользователя
     */
    func login(userName: String,
               password: String,
               completionHandler: @escaping (DataResponse<LoginResult>) -> Void)
    
    /// Выполняет выход из системы
    func logout()
    
    /**
     Выполняет регистрацию пользователя
     - Parameters:
       - userData: Данные пользователя `UserData`
     */
    func register(userData: UserData,
                  completionHandler: @escaping (DataResponse<RegisterResult>) -> Void)
    
}
