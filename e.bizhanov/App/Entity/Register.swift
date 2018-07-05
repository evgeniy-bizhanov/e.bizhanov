//
//  Register.swift
//  e.bizhanov
//
//  Created by Евгений Бижанов on 05.07.2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

struct RegisterResult: Codable {
    let result: Int
    let userMessage: String
}

struct RegisterUser {
    let id: Int
    let username: String
    let password: String
    let email: String
    let gender: String
    let creditCard: String
    let bio: String
}
