//
//  UIView+.swift
//  MyUIStackView
//
//  Created by 구태호 on 4/16/24.
//

import UIKit


extension UIView {
    convenience init(backgroundColor: UIColor = .clear) {
        self.init()
        self.backgroundColor = backgroundColor
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
