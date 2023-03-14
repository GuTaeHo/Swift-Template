//
//  ToastLabel.swift
//  MyBible
//
//  Created by 구태호 on 2023/03/14.
//

import UIKit


/// 토스트 표시를 위한 라벨
class ToastLabel: UILabel {
    private var padding = UIEdgeInsets(top: 18.0, left: 12.0, bottom: 18.0, right: 12.0)
    
    /// 패딩 조정 시 사용
    convenience init(padding: UIEdgeInsets) {
        self.init()
        self.padding = padding
    }
    
    /// 텍스트 변경 시 호출
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: padding.top, left: padding.left, bottom: padding.bottom, right: padding.right)
        super.drawText(in: rect.inset(by: insets))
    }
    
    /// 라벨 고유 사이즈 변경
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + padding.left + padding.right, height: size.height + padding.top + padding.bottom)
    }
    
    /// 크기가 변경될 때 마다 최대 사이즈 재조정
    override var bounds: CGRect {
        didSet { preferredMaxLayoutWidth = bounds.width - (padding.left + padding.right) }
    }
}
