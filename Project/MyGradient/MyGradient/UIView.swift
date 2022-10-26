//
//  UIView.swift
//  MyGradient
//
//  Created by 구태호 on 2022/10/13.
//

import UIKit

extension UIView {
    /// 뷰 그래디언트
    /// - parameter startColor: 시작 색상
    func gradient(startColor: UIColor = .black) {
        let gradient = CAGradientLayer()
        
        gradient.frame = self.bounds
        gradient.colors = [startColor.cgColor, UIColor.clear.cgColor]
        gradient.locations = [0.8]
        self.layer.mask = gradient
        
        self.backgroundColor = startColor
    }
}
