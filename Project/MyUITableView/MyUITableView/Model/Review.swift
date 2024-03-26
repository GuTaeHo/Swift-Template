//
//  Review.swift
//  MyUITableView
//
//  Created by 구태호 on 3/26/24.
//

import Foundation

struct Review: Codable {
    var userName: String
    var menuName: String
    var starScore: Double
    var content: String
    var imageNames: [String]
    var date: Date
}
