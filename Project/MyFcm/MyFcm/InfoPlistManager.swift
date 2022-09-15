//
//  InfoPlistManager.swift
//  MyFcm
//
//  Created by 구태호 on 2022/09/15.
//

import Foundation

class InfoPlistManager {
    public static var FcmApiKey: String {
        get {
            // 1
            guard let filePath = Bundle.main.path(forResource: "ApiKeys", ofType: "plist") else {
                fatalError("Couldn't find file 'ApiKeys.plist'.")
            }
            // 2
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "FCM_API_KEY") as? String else {
                fatalError("Couldn't find key 'API_KEY_FCM' in 'ApiKeys.plist'.")
            }
            return value
        }
    }
}
