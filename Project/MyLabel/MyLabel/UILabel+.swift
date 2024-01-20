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
//    /// 행간을 추가합니다.
//    @discardableResult
//    func concatenateLineSpacing(_ space: CGFloat) -> UILabel? {
//        let text = text ?? ""
//        
//        var attributedMutableString: NSMutableAttributedString
//        if let attributedText = attributedText {
//            attributedMutableString = NSMutableAttributedString(attributedString: attributedText)
//        } else {
//            attributedMutableString = NSMutableAttributedString(string: text)
//        }
//        
//        let style = NSMutableParagraphStyle()
//        style.lineSpacing = space
//        
//        attributedMutableString.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: text.count))
//        self.attributedText = attributedMutableString
//        return self
//    }
//    
//    /// 자간을 추가합니다.
//    @discardableResult
//    func concatenateLetterSpacing(_ space: CGFloat) -> UILabel? {
//        guard let text = text else { return nil }
//        
//        var attributedMutableString: NSMutableAttributedString
//        if let attributedText = attributedText {
//            attributedMutableString = NSMutableAttributedString(attributedString: attributedText)
//        } else {
//            attributedMutableString = NSMutableAttributedString(string: text)
//        }
//        
//        attributedMutableString.addAttribute(.kern, value: space, range: NSRange(location: 0, length: text.count))
//        self.attributedText = attributedMutableString
//        return self
//    }
    
    /// 문자열 사이즈 반환
    func size(font: FontType = .normal) -> CGSize {
        return (text! as NSString).size(withAttributes: [.font : self.font!])
    }
}
