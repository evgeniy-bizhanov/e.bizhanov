//
//  Profile.swift
//  e.bizhanov
//
//  Created by Евгений Бижанов on 06.07.2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

struct ChangeUserDataResult: Codable {
    let result: Int
}

struct UserData {
    let id: Int
    let username: String
    let password: String
    let email: String
    let gender: String
    let creditCard: String
    let bio: String
}
