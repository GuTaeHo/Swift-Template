//
//  Response.swift
//  MyAwaitAsync
//
//  Created by 구태호 on 2023/07/30.
//

import Foundation


struct Response<T: Codable>: Codable {
    var code: Int?
    var message: String?
    var result: T?
    
    enum CodingKeys: String, CodingKey {
        case code
        case message
        case result
    }
}
