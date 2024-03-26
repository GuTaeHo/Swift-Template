//
//  Shop.swift
//  MyUITableView
//
//  Created by 구태호 on 3/26/24.
//

import Foundation

struct Shop: Codable {
    var imageNames: [String]
    var content: String
    var starScore: Double
    var canReview: Bool
}
