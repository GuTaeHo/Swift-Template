//
//  UIView+.swift
//  MyCALayer
//
//  Created by 구태호 on 2023/09/06.
//

import UIKit

extension UIView {
    /// 레이어 마스킹
    /// - Parameters
    ///     - rect: 마스킹 영역
    ///     - cornerRadius: 모서리 반경 (기본값: 0)
    ///     - isPierce: 레이어 겹침 처리
    func mask(rect: CGRect, cornerRadius: CGFloat = 0, isPierce: Bool) {
        // 1. 마스킹 뼈대가 될 패스 생성
        let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
        if isPierce {
            let ovalPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height), cornerRadius: cornerRadius)
            path.append(ovalPath)
        }
        
        // 2. 마스킹 처리될 레이어 생성
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        
        if isPierce {
            maskLayer.fillRule = .evenOdd
        }
        
        // 3. 뷰 기본 레이어에 마스킹
        layer.mask = maskLayer
    }
    /// 시머 이펙트 적용
    /// - Important: 올바르게 레이아웃 된 시점일 때 적용됨
    func shimmer(duration: CGFloat) {
        let gradientLayer = CAGradientLayer()
        let gradationColor = [UIColor.clear, .white.withAlphaComponent(0.5), .clear]
        gradientLayer.frame = bounds
        gradientLayer.colors = gradationColor.map { $0.cgColor }
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.transform = CATransform3DMakeRotation(CGFloat(45 * Double.pi / 180), 0, 0, 1)
        self.layer.mask = gradientLayer
        
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.fromValue = -bounds.size.width
        animation.toValue = bounds.size.width
        animation.repeatCount = .infinity
        animation.duration = duration
        animation.timingFunction = CAMediaTimingFunction(name: .easeIn)
        gradientLayer.add(animation, forKey: "animationKey")
    }
}
