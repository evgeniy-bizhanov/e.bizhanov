//
//  AbstractErrorParser.swift
//  e.bizhanov
//
//  Created by Евгений Бижанов on 04.07.2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import Foundation

protocol ​AbstractErrorParser​ {
    func parse(_ result: Error) -> Error
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error?
}
