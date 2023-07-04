//
//  UILabel+.swift
//  MyLabel
//
//  Created by 구태호 on 2023/07/04.
//

import UIKit


extension UILabel {
    /// 자간 지정 (기본값 = 0.5)
    func characterSpacing(_ kernValue: Double = 0.5) {
        guard let text = text, !text.isEmpty else { return }
        let string = NSMutableAttributedString(string: text)
        string.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: NSRange(location: 0, length: string.length - 1))
        attributedText = string
    }
}
