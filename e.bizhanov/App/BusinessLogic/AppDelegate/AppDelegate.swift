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
        
        let catalog: CatalogRequestFactory = requestFactory.makeCatalogRequestFactory()
        
        let filter = FilterData(categoryId: 1)
        catalog.getProducts(pageNumber: 1, filterData: filter) { response in
            switch response.result {
            case .success(let login):
                print("---\nproducts: \(login)")
            case .failure(let error):
                print(error)
            }
        }
        
        // Login
        let auth: AuthRequestFactory = requestFactory.makeAuthRequestFactory()
        auth.login(userName: "some-username", password: "some-password") { response in
            switch response.result {
            case .success(let login):
                print("---\nlogin: \(login)")
            case .failure(let error):
                print(error)
            }
        }
        
        // Logout
        auth.logout()
        
        // Register
        let userData = UserData(
            id: 123,
            username: "username",
            password: "password",
            email: "email",
            gender: "m",
            creditCard: "credit",
            bio: "bio"
        )
        
        auth.register(userData: userData) { response in
            switch response.result {
            case .success(let result):
                print("---\nregister: \(result)")
            case .failure(let error):
                print(error)
            }
        }
        
        // Change user data
        let profile: ProfileRequestFactory = requestFactory.makeProfileRequestFactory()
        
        profile.changeProfile (userData: userData) { response in
            switch response.result {
            case .success(let result):
                print("---\nchange-profile: \(result)")
            case .failure(let error):
                print(error)
            }
        }
        
        return true
    }
}
