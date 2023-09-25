//
//  Product.swift
//  MyDiffableDatasource
//
//  Created by 구태호 on 2023/09/25.
//

import Foundation


struct Product: Codable, Hashable {
    var id = UUID()
    var code: Int
    var thumbnail: String
    var brand: String
    var name: String
    var price: Int
    
    init(code: Int, thumbnail: String, brand: String, name: String, price: Int) {
        self.code = code
        self.thumbnail = thumbnail
        self.brand = brand
        self.name = name
        self.price = price
    }
}
