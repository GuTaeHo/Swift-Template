//
//  UIColor.swift
//  MyCustomView
//
//  Created by 구태호 on 2023/03/09.
//

import UIKit

extension UIColor {
    /// - parameter r: 0 ~ 255 사이 값 지정
    /// - parameter g: 0 ~ 255 사이 값 지정
    /// - parameter b: 0 ~ 255 사이 값 지정
    /// - parameter a: 0.0 ~ 1.0 사이 값 지정
    /// - note: UIColor(r:g:b:a) 형태로 사용
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
}
