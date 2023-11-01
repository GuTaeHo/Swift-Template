//
//  UILabel+.swift
//  MyLabel
//
//  Created by 구태호 on 2023/07/04.
//

import UIKit

enum FontType {
    case light
    case normal
    case bold
}

extension UILabel {
    /// 자간 지정 (기본값 = 0.0)
    func characterSpacing(_ kernValue: CGFloat = 0.0) {
        guard let text = text, !text.isEmpty else { return }
        let string = NSMutableAttributedString(string: text)
        string.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: NSRange(location: 0, length: string.length - 1))
        attributedText = string
    }
    
    /// 문자열 사이즈 반환
    func size(font: FontType = .normal) -> CGSize {
        return (text! as NSString).size(withAttributes: [.font : self.font!])
    }
}
