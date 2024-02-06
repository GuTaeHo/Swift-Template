//
//  NSMutableAttributedString+.swift
//  MyLabel
//
//  Created by 구태호 on 2/6/24.
//

import UIKit


extension NSMutableAttributedString {
    /// 속성이 지정된 문자열 생성
    static func mutableStyledText(_ text: String, type: UIFont.FontType, size: CGFloat, color: UIColor) -> NSMutableAttributedString {
        let attr: [NSAttributedString.Key : Any] = [
            .foregroundColor : color,
            .font : UIFont.font(type, ofSize: size),
        ]
        
        return NSMutableAttributedString(string: text, attributes: attr)
    }
    
    /// 행간 속성 추가
    func appendParagraphStyle(_ spacing: CGFloat) -> NSMutableAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        
        addAttribute(.paragraphStyle, value: paragraphStyle, range: .init(location: 0, length: self.length))
        return self
    }
}
