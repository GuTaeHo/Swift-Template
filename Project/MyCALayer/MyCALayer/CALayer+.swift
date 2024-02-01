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
}
