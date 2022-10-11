//
//  UIView.swift
//  MyUIViewShadow
//
//  Created by 구태호 on 2022/10/11.
//

import UIKit

/*
 UIView 의 clipsToBounds 또는 UIView.layer 에 masksToBounds 값이 false 로 설정된 경우,
 현재 뷰의 그림자가 부모 뷰의 사이즈보다 크더라도 그림자가 표시되는 것을 확인할 수 있음
 */

extension UIView {
    /// 뷰 그림자 설정
    /// - parameter width: 그림자 표시를 위한 테두리 굵기
    /// - parameter color: 그림자 색상 (default: .black)
    /// - parameter offset: 그림자 위치 (default: CGSize(2.0, 2.0))
    /// - parameter radius: 그림자 퍼짐 효과 정도 (default: CGFloat(6.0))
    /// - parameter opacity: 그림자 투명도 (default: Float(1.0), 0.0 ~ 1.0 사이 설정)
    func shadow(width: CGFloat = 0, color: UIColor = .black, offset: CGSize = CGSize(),
                radius: CGFloat = 6.0, opacity: Float = 1.0) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
    }
}
