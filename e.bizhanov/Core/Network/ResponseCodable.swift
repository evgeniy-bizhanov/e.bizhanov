//
//  ResponseCodable.swift
//  e.bizhanov
//
//  Created by Евгений Бижанов on 05.07.2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import Alamofire

extension DataRequest {
    typealias Completion<T> = (DataResponse<T>) -> Void
    
    @discardableResult
    func responseCodable<T: Decodable>(
        errorParser: ​AbstractErrorParser​,
        queue: DispatchQueue?,
        completionHandler: @escaping Completion<T>) -> Self {
        let responseSerializer = DataResponseSerializer<T> { _, response, data, error in
            if let error = errorParser.parse(response: response, data: data, error: error) {
                return .failure(error)
            }
            
            let result = Request.serializeResponseData(response: response, data: data, error: error)
            
            switch result {
            case .success(let data):
                do {
                    let value = try JSONDecoder().decode(T.self, from: data)
                    return .success(value)
                } catch {
                    let customError = errorParser.parse(error)
                    return .failure(customError)
                }
            case .failure(let error):
                let customError = errorParser.parse(error)
                return .failure(customError)
            }
        }
        
        return response(queue: queue, responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
}
