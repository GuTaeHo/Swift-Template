//
//  UIEdgeInsets+.swift
//  MyUIStackView
//
//  Created by 구태호 on 4/16/24.
//

import UIKit

extension UIEdgeInsets {
    init(all value: CGFloat) {
        self.init(top: value, left: value, bottom: value, right: value)
    }
    
    init(horizontal hValue: CGFloat, vertical vValue: CGFloat) {
        self.init(top: vValue, left: hValue, bottom: vValue, right: hValue)
    }
    
    init(horizontal value: CGFloat) {
        self.init(top: 0, left: value, bottom: 0, right: value)
    }
    
    init(vertical value: CGFloat) {
        self.init(top: value, left: 0, bottom: value, right: 0)
    }
}
