//
//  NSAttributedString+.swift
//  MyLabel
//
//  Created by 구태호 on 2/6/24.
//

import UIKit


// 읽기 전용의 속성이 적용된 String.
// 만약 속성을 변경하고 싶다면 `NSMutableAttributedString` 을 사용.
extension NSAttributedString {
    /// 속성 추가 가능한 문자열로 변경한다.
    var toMutable: NSMutableAttributedString {
        NSMutableAttributedString(attributedString: self)
    }
    
    /// 속성이 지정된 문자열을 만든다.
    static func styledText(_ text: String, type: UIFont.FontType, size: CGFloat, color: UIColor) -> NSAttributedString {
        let attr: [NSAttributedString.Key : Any] = [
            .foregroundColor : color,
            .font : UIFont.font(type, ofSize: size),
        ]
        
        let attrStr = NSAttributedString(string: text, attributes: attr)
        return attrStr
    }
}
