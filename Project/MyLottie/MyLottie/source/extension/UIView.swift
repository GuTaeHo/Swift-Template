//
//  UIView.swift
//  MyLottie
//
//  Created by 구태호 on 2023/02/10.
//

import UIKit

extension UIView {
    /// 뷰 투명도 조정
    /// - parameter value: 투명도 조정 값 (0 ~ 1 사이)
    /// - parameter isAllViews: 하위 모든 뷰에 적용 여부(default: false)
    /// - note: isAllViews 가 false 인 경우 해당하는 뷰에만 적용됨
    func alpha(value: CGFloat, isAllViews: Bool = false) {
        if isAllViews {
            self.alpha = value
        } else {
            self.backgroundColor = self.backgroundColor?.withAlphaComponent(value)
        }
    }
}
