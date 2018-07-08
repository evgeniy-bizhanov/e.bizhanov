//
//  ProfileRequestFactory.swift
//  e.bizhanov
//
//  Created by Евгений Бижанов on 06.07.2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import Alamofire

protocol ProfileRequestFactory {
    
    /**
     Изменяет данные в профиле пользователя пользователя
     - Parameters:
       - userData: Данные пользователя `UserData`
     */
    func changeProfile(userData: UserData,
                       completionHandler: @escaping (DataResponse<ChangeUserDataResult>) -> Void)
    
}
