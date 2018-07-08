//
//  BaseRequestFactory.swift
//  e.bizhanov
//
//  Created by Евгений Бижанов on 09.07.2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import Alamofire

class BaseRequestFactory: AbstractRequestFactory {
    let errorParser: ​AbstractErrorParser​
    let sessionManager: SessionManager
    let queue: DispatchQueue?
    
    lazy var baseUrl: URL! = {
        return URL(string: AppConfig.Network.basePath)
    }()
    
    init (
        errorParser: ​AbstractErrorParser​,
        sessionManager: SessionManager,
        queue: DispatchQueue? = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}
