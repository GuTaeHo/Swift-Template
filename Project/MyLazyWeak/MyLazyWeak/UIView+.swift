//
//  UIView+.swift
//  MyLazyWeak
//
//  Created by 구태호 on 4/3/24.
//

import UIKit


extension UIView {
    /// 탭 액션 등록
    /// - parameter isAnimation: 토글 애니메이션 표시 여부 (기본값: false)
    /// - parameter action: 뷰 클릭 시 호출될 클로저
    /// - warning: action 은 **탈출 클로저**. weak self 키워드 반드시 사용할 것!
    func addAction(isAnimation: Bool = false, action: @escaping () -> ()) {
        let recognizer = TapGestureRecognizer(target: self, action: #selector(self.tapGesture(_:)))
        recognizer.action = action
        
        recognizer.numberOfTapsRequired = 1
        recognizer.numberOfTouchesRequired = 1
        
        self.addGestureRecognizer(recognizer)
        self.isUserInteractionEnabled = true
    }
    
    @objc func tapGesture(_ sender: TapGestureRecognizer) {
        sender.action?()
    }
}

/// 커스텀 탭 인식기
class TapGestureRecognizer: UITapGestureRecognizer {
    var action: (() -> ())? = nil
}
