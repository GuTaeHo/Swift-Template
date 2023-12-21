//
//  Product.swift
//  MyDiffableDatasource
//
//  Created by 구태호 on 2023/09/25.
//

import Foundation


struct Product: Codable, Hashable {
    var identifier = UUID()
    var code: Int
    var thumbnail: String
    var brand: String
    var name: String
    var price: Int
    
    /// dataSource가 snapshot이 달라진 것 인식하기 위해 필요함
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier.hashValue)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    init(code: Int, thumbnail: String, brand: String, name: String, price: Int) {
        self.code = code
        self.thumbnail = thumbnail
        self.brand = brand
        self.name = name
        self.price = price
    }
}
