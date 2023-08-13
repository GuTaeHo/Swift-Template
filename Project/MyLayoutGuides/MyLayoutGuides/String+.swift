//
//  String+.swift
//  MyLayoutGuides
//
//  Created by 구태호 on 2023/08/14.
//

import UIKit


extension String {
    static func randomString(length: Int) -> String {
        let randomString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789가나다라마바사아자차카타파하"
        let str = (0 ..< length).map{ _ in randomString.randomElement()! }
        return String(str)
    }
}
