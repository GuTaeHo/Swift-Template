//
//  UIColor.swift
//  MyToast
//
//  Created by 구태호 on 2023/03/07.
//

import UIKit

extension UIColor {
    /// - note: UIColor(r:g:b:a) 형태로 사용
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
}
