//
//  UIView.swift
//  MyPhotoKit
//
//  Created by 구태호 on 6/10/24.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
