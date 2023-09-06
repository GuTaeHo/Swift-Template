//
//  UIView+.swift
//  MyCALayer
//
//  Created by 구태호 on 2023/09/06.
//

import UIKit

extension UIView {
    /// 해당 영역
    func mask(rect: CGRect, isRectMasking: Bool) {
        // 1. path 인스턴스로 경로 정보 획득
        let path = CGMutablePath()
        if isRectMasking {
            let allRect = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
            path.addRect(allRect)
        }
        path.addRect(rect)
        
        // 2. CAShapeLayer 인스턴스에 위 path 인스턴스 사용
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path
        if isRectMasking {
            shapeLayer.fillRule = .evenOdd
        }
        
        // 3. mask에 shapeLayer 인스턴스 사용
        layer.mask = shapeLayer
    }
}
