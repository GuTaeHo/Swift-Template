//
//  Encodable+.swift
//  MyUrlSession
//
//  Created by 구태호 on 3/11/24.
//

import Foundation


extension Encodable {
    var toJson: String? {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        
        guard let jsonData = try? jsonEncoder.encode(self) else {
            return nil
        }
        
        return String(data: jsonData, encoding: .utf8)
    }
}
