//
//  UserDefaultsUtil.swift
//  MyUserDefaults
//
//  Created by 구태호 on 2022/07/20.
//

import Foundation

class UserDefaultsUtil {
    private static let KEYWORDS = "keywords"
    
    public static func getObjects() -> [Cocobean]? {
        if let data = UserDefaults.standard.value(forKey: KEYWORDS) as? Data {
            return try? PropertyListDecoder().decode([Cocobean].self, from: data)
        }
        
        return nil
    }
    
    public static func setObject(keyword: String) {
        
    }
    
    public static func printObjects() {
        if let data = UserDefaults.standard.value(forKey: KEYWORDS) as? Data {
            print(try? PropertyListDecoder().decode([Cocobean].self, from: data))
        }
    }
}
