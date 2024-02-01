//
//  CALayer+.swift
//  MyCALayer
//
//  Created by 구태호 on 2/1/24.
//

import UIKit


extension CALayer {
    /// 여러 레이어 추가
    func addSublayers(_ layers: CALayer...) {
        layers.forEach { addSublayer($0) }
    }
    
    /// 레이어 마스킹 처리
    /// - Parameters
    ///     - rect: 마스킹 영역
    ///     - cornerRadius: 모서리 반경
    func mask(rect: CGRect, cornerRadius: CGFloat) {
        let path = CGMutablePath()
        path.addRect(.init(origin: .zero, size: bounds.size))
        let ovalPath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
        path.addPath(ovalPath.cgPath)
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = path
        maskLayer.fillRule = .evenOdd
        
        mask = maskLayer
    }
}
