//
//  UIStackView+.swift
//  MyCodeBaseViews
//
//  Created by 구태호 on 11/20/23.
//

import UIKit


extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach({ self.addArrangedSubview($0) })
    }
}
