//
//  UIView.swift
//  MyRegex
//
//  Created by 구태호 on 2023/03/09.
//

import UIKit

extension UIView {
    /// 애니메이션 지속시간 설정
    private var ANIMATION_TARGET_INTERVAL: CGFloat {
        get {
            return 0.3
        }
    }
    
    /// 토글 애니메이션
    func toggle() {
        UIView.animate(withDuration: 0.07,
                       delay: 0,
                       options: [.allowUserInteraction, .curveLinear],
                       animations: { [weak self] in
            self?.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) {  (done) in
            UIView.animate(withDuration: 0.05,
                           delay: 0,
                           options: [.allowUserInteraction, .curveLinear],
                           animations: { [weak self] in
                self?.transform = .identity
            })
        }
    }
    
    /// 뷰 숨김
    /// - parameter isAnimate: 애니메이션 사용 여부 (기본값: false)
    func hidden(isAnimate: Bool = false) {
        if self.isHidden {
            return
        }
        
        if isAnimate {
            UIView.animate(withDuration: self.ANIMATION_TARGET_INTERVAL, animations: {
                self.isHidden = true
                self.alpha = 0
            })
        } else {
            self.isHidden = true
            self.alpha = 0
        }
    }
    
    /// 뷰 표시
    /// - parameter isAnimate: 애니메이션 사용 여부 (기본값: false)
    func display(isAnimate: Bool = false) {
        if isAnimate {
            UIView.animate(withDuration: self.ANIMATION_TARGET_INTERVAL) {
                self.isHidden = false
                self.alpha = 1
            }
        } else {
            self.isHidden = false
            self.alpha = 1
        }
    }
    
    /// 탭 액션 등록
    /// - parameter isAnimation: 토글 애니메이션 표시 여부 (기본값: false)
    /// - parameter action: 뷰 클릭 시 호출될 클로저
    func addAction(isAnimation: Bool = false, action: @escaping () -> ()) {
        let recognizer = TapGestureRecognizer(target: self, action: #selector(self.tapGesture(_:)))
        recognizer.isAnimation = isAnimation
        recognizer.action = action
        
        recognizer.numberOfTapsRequired = 1
        recognizer.numberOfTouchesRequired = 1
        
        self.addGestureRecognizer(recognizer)
        self.isUserInteractionEnabled = true
    }
    
    @objc func tapGesture(_ sender: TapGestureRecognizer) {
        if sender.isAnimation {
            self.toggle()
        }
        sender.action!()
    }
}

/// 커스텀 탭 인식기
class TapGestureRecognizer: UITapGestureRecognizer {
    var isAnimation: Bool = false
    var action: (() -> ())? = nil
}
