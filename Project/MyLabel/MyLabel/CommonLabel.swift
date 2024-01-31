//
//  CommonLabel.swift
//  MyLabel
//
//  Created by 구태호 on 2023/07/04.
//

import UIKit

@IBDesignable
class CommonLabel: UILabel {
    private var _fontSize: Int = 10
    private var _fontType: UIFont.FontType = .pretendardRegular
    
    var fontType: UIFont.FontType {
        get { _fontType }
        set {
            _fontType = newValue
            fontSize = _fontSize
        }
    }
    
    @IBInspectable
    var fontSize: Int {
        set {
            _fontSize = newValue
            let attributedString: NSMutableAttributedString!
            if let attributedText = attributedText {
                attributedString = NSMutableAttributedString(attributedString: attributedText)
            } else {
                attributedString = NSMutableAttributedString(string: text ?? "")
                text = nil
            }
            
            attributedString.addAttribute(.font,
                                          value: UIFont.font(_fontType, ofSize: CGFloat(newValue)),
                                          range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
        }
        
        get {
            if let font = attributedText?.attribute(.font, at: 0, effectiveRange: .none) as? UIFont {
                return Int(font.pointSize)
            } else {
                return 12
            }
        }
    }
    
    @IBInspectable
    var letterSpace: CGFloat {
        set {
            let attributedString: NSMutableAttributedString!
            if let attributedText = attributedText {
                attributedString = NSMutableAttributedString(attributedString: attributedText)
            } else {
                attributedString = NSMutableAttributedString(string: text ?? "")
                text = nil
            }
            
            attributedString.addAttribute(.kern,
                                          value: newValue,
                                          range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
        }
        
        get {
            if let currentLetterSpace = attributedText?.attribute(.kern, at: 0, effectiveRange: .none) as? CGFloat {
                return currentLetterSpace
            } else {
                return 0
            }
        }
    }
    
    
    @IBInspectable
    var lineSpace: CGFloat {
        set {
            let attributedString: NSMutableAttributedString!
            if let attributedText = attributedText {
                attributedString = NSMutableAttributedString(attributedString: attributedText)
            } else {
                attributedString = NSMutableAttributedString(string: text ?? "")
                text = nil
            }
            
            let style = NSMutableParagraphStyle()
            style.lineSpacing = newValue
            
            attributedString.addAttribute(.paragraphStyle,
                                          value: style,
                                          range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
        }
        
        get {
            if let currentLetterSpace = attributedText?.attribute(.paragraphStyle, at: 0, effectiveRange: .none) as? CGFloat {
                return currentLetterSpace
            } else {
                return 0
            }
        }
    }
}
