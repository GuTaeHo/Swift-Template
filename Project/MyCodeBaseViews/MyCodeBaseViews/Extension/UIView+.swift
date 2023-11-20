//
//  UIView+.swift
//  MyCodeBaseViews
//
//  Created by 구태호 on 11/20/23.
//

import UIKit


extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({ self.addSubview($0) })
    }
}
