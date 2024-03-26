//
//  NSObject+.swift
//  MyTableViewSectionHeaderAndFooterView
//
//  Created by 구태호 on 3/26/24.
//

import Foundation


extension NSObject {
    /// 클래스 네임
    var className: String {
        return Self.className
    }

    /// 클래스 네임
    static var className: String {
        return String(describing: self)
    }
}
