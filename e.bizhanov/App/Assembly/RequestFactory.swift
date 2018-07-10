//
//  RequestFactory.swift
//  e.bizhanov
//
//  Created by Евгений Бижанов on 05.07.2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import Alamofire

class RequestFactory {
    func makeErrorParser() -> ​AbstractErrorParser​ {
        return ErrorParser()
    }
    
    lazy var commonSessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        
        let manager = SessionManager(configuration: configuration)
        return manager
    }()
    
    let sessionQueue = DispatchQueue.global(qos: .utility)
    
    func makeAuthRequestFactory<T>() -> T! {
        let errorParser = makeErrorParser()
        return Auth(errorParser: errorParser, sessionManager: commonSessionManager, queue: sessionQueue) as? T
    }
    
    func makeProfileRequestFactory<T>() -> T! {
        let errorParser = makeErrorParser()
        return Profile(errorParser: errorParser, sessionManager: commonSessionManager, queue: sessionQueue) as? T
    }
}

// Делаем через extension, что бы можно было перетаскивать код в проект, не занимаясь постоянным переименовыванием классов
extension RequestFactory {
    func makeCatalogRequestFactory<T>() -> T! {
        let errorParser = makeErrorParser()
        return Catalog(errorParser: errorParser, sessionManager: commonSessionManager, queue: sessionQueue) as? T
    }
}
