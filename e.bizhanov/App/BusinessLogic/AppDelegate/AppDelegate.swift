//
//  AppDelegate.swift
//  e.bizhanov
//
//  Created by Евгений Бижанов on 30.06.2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let requestFactory = RequestFactory()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Login
        let auth: AuthRequestFactory? = requestFactory.makeRequestFactory()
        auth?.login(userName: "some-username", password: "some-password") { response in
            switch response.result {
            case .success(let login):
                print("---\nlogin: \(login)")
            case .failure(let error):
                print(error)
            }
        }
        
        // Logout
        auth?.logout { response in
            switch response.result {
            case .success(let logout):
                print("---\nlogout: \(logout)")
            case .failure(let error):
                print(error)
            }
        }
        
        // Register
        let register: RegisterRequestFactory? = requestFactory.makeRequestFactory()
        let userInfo = RegisterUser(id: -1,
                                    username: "username",
                                    password: "password",
                                    email: "email",
                                    gender: "m",
                                    creditCard: "credit",
                                    bio: "bio")
        
        register?.register(userInfo: userInfo) { response in
            switch response.result {
            case .success(let result):
                print("---\nregister: \(result)")
            case .failure(let error):
                print(error)
            }
        }
        
        return true
    }
}
