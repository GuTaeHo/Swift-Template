//
//  Data+.swift
//  MyAwaitAsync
//
//  Created by 구태호 on 2023/09/04.
//

import Foundation


extension Data {
    func printPrettyJson() {
        do {
            let json = try JSONSerialization.jsonObject(with: self, options: [])
            let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            guard let jsonString = String(data: data, encoding: .utf8) else {
                print("Inavlid data")
                return
            }
            print(jsonString)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
