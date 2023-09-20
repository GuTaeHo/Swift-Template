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
}
