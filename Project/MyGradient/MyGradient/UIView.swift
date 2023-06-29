//
//  UIView.swift
//  MyGradient
//
//  Created by 구태호 on 2022/10/13.
//

import UIKit

enum CommonDirection {
    case bottom
    case top
}

extension UIView {
    /// 뷰 그래디언트 (투명)
    /// - parameter startColor: 시작 색상
    /// - parameter gradientDirection: 그래디언트 방향
    func transparentGradient(startColor: UIColor = .black, gradientDirection: CommonDirection = .bottom) {
        let gradient = CAGradientLayer()
        
        gradient.frame = self.bounds
        
        switch gradientDirection {
        case .bottom:
            gradient.colors = [startColor.cgColor, UIColor.clear.cgColor]
            break
        case .top:
            gradient.colors = [UIColor.clear.cgColor, startColor.cgColor]
            break
        }
        
        /// 그래디언트 색상이 전환되는 지점
        /// - note: 0.0 = 시작부터 전환, 0.5 = 중간부터 전환
        gradient.locations = [0.0]
        
        layer.mask = gradient
        
        backgroundColor = startColor
    }
}
