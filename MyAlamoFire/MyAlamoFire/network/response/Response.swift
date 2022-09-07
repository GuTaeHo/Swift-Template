//
//  Response.swift
//  MyAlamoFire
//
//  Created by 구태호 on 2022/06/21.
//

import Foundation

struct Response<T: Codable>: Codable {
    var code: String?
    var msg: String?
    var data: T?
}
