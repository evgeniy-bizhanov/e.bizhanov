//
//  HttpStubHelper.swift
//  e.bizhanovTests
//
//  Created by Евгений Бижанов on 10.07.2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import OHHTTPStubs

class HTTPStubHelper {
    class func setup(forApiMethod methodName: String) {
        stub(condition: isMethodGET() && pathEndsWith(methodName)) { request in
            let fileUrl = Bundle.main.url(forResource: methodName, withExtension: "stub")!
            return OHHTTPStubsResponse(
                fileURL: fileUrl,
                statusCode: 200,
                headers: nil
            )
        }
    }
    
    private init(){}
}
