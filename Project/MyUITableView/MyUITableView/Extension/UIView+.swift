//
//  UIView+.swift
//  MyUITableView
//
//  Created by 구태호 on 3/26/24.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
