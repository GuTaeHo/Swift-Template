//
//  UILabel.swift
//  MyBible
//
//  Created by 구태호 on 2023/03/14.
//

import UIKit

/**
 1. 문자열에 스타일을 적용하기 위해 **NSMutableAttributedString 형태**로 변경
 2. 적용할 **범위 생성**
 3. **속성** 추가
 4. 해당 **라벨에 적용**
 */

extension UILabel {
    /// 아무런 속성이 적용이 되지않은 기본 상태로 되돌릴 경우 사용
    func normal() {
        guard let text = self.text else { return }
        
        let attributedString = NSMutableAttributedString.init(string: text)
        attributedText = attributedString
    }
    
    func underline() {
        guard let text = self.text else { return }
        
        // 1. 문자열에 스타일을 적용하기 위해 NSMutableAttributedString 형태로 변경
        // MARK: NSMutableAttributedString 은 NSAttributedString 의 특정 범위에 다양한 스타일을 설정할 수 있는 타입
        let attributedString = NSMutableAttributedString.init(string: text)
        /// - note: 단일 속성을 적용할 경우 -> addAttribute(_: value: range)
        /// - note: 다중 속성을 적용할 경우 -> addAttributes(_: range)
        /*
        let attributes: [NSMutableAttributedString.Key: Any] = [
            .underlineStyle: NSNumber(value: 1)
        ]
         attributedString.addAttributes(_:range)
         */
        // 2. 적용할 범위 생성
        let range = NSRange.init(location: 0, length: attributedString.length)
        // 3. 속성 추가
        attributedString.addAttribute(.underlineStyle, value: 1, range: range)
        // 4. 해당 라벨에 적용
        self.attributedText = attributedString
    }
}
