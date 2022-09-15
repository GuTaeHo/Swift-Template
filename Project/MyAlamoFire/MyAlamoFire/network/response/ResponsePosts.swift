//
//  ResponsePosts.swift
//  MyAlamoFire
//
//  Created by 구태호 on 2022/06/22.
//

import Foundation

struct ResponsePosts: Codable {
    var userId: Int?
    var id: Int?
    var title: String?
    var body: String?
}
