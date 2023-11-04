//
//  CustomTextField.swift
//  MyIntrinsicContentSize
//
//  Created by 구태호 on 11/4/23.
//

import UIKit


class CustomTextField: UILabel {
    private let TOP_PADDING: CGFloat = 12.0
    private let LEFT_PADDING: CGFloat = 18.0
    private let BOTTOM_PADDING: CGFloat = 12.0
    private let RIGHT_PADDING: CGFloat = 18.0
    
    override func invalidateIntrinsicContentSize() {
        super.invalidateIntrinsicContentSize()
    }
    
    // MARK: intrinsicContentSize 를 재정의하면, 뷰 자체의 본질적인(intrinsic) 사이즈를 변경할 수 있다.
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        
        return CGSize(width: size.width + LEFT_PADDING + RIGHT_PADDING, height: size.height + TOP_PADDING + BOTTOM_PADDING)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        print("intrinsicContentSize 변경 전 CustomTextField.frame - \(rect)")
        let size = intrinsicContentSize
        let origin = rect.origin
        
        let updatedRect = CGRect(origin: origin, size: size)
        print("intrinsicContentSize 변경 후 CustomTextField.frame - \(updatedRect)")
    }
}
