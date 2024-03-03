//
//  UIView+.swift
//  MyButton
//
//  Created by 구태호 on 2/29/24.
//

import UIKit

extension UIView {
    
    /// UIView 이벤트 등록
    /// - parameter isAnimation: 애니메이션 여부 (기본값: false)
    /// - warning: 해당 함수 호출 시 상호작용(isUserInteractionEnabled -> true) 활성화 됨
    func addAction(isAnimation: Bool = false, action : @escaping () -> ()) {
        let tap = TapGestureRecognizer(target: self, action: #selector(self.tapGesture(_:)))
        tap.action = action
        
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }
    
    @objc func tapGesture(_ sender: TapGestureRecognizer) {
        sender.action!()
    }
    
    class TapGestureRecognizer: UITapGestureRecognizer {
        var action: (() -> ())?
    }
}
