//
//  NSObject.swift
//  MyXibCustomView
//
//  Created by 구태호 on 2023/07/23.
//

import Foundation


extension NSObject {
    var className: String {
        get {
            return String(describing: self)
        }
    }
    
    static var className: String {
        get {
            return String(describing: Self.self)
        }
    }
}
