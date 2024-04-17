//
//  NSObject+.swift
//  MyCodeBaseViews
//
//  Created by 구태호 on 10/21/23.
//

import Foundation


extension NSObject {
    /// 클래스 명을 반환합니다.
    var className: String {
        return Self.className
    }

    /// 클래스 명을 반환합니다.
    static var className: String {
        return String(describing: self)
    }
}
