//
//  Encodable.swift
//  MyAlamoFire
//
//  Created by 구태호 on 2023/09/20.
//

import Foundation

extension Encodable {
    var convertToJson: String? {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        
        do {
            let jsonData = try jsonEncoder.encode(self)
            return String(data: jsonData, encoding: .utf8)
        } catch {
            return nil
        }
    }
}
