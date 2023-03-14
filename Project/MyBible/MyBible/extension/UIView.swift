//
//  File.swift
//  MyCustomView
//
//  Created by 구태호 on 2023/03/09.
//

import UIKit


extension UIView {
    /// 방향 타입 정의
    enum Direction: String {
        case top
        case bottom
        case left
        case right
    }
    
    static func loadFromNib<T>() -> T? {
        let identifier = String(describing: T.self)
        let view = Bundle.main.loadNibNamed(identifier, owner: self, options: nil)?.first
        return view as? T
    }
    
    /// 애니메이션 지속시간 설정
    static var animationInterval = 0.3
    
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
            UIView.animate(withDuration: UIView.animationInterval, animations: {
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
            UIView.animate(withDuration: UIView.animationInterval) {
                self.isHidden = false
                self.alpha = 1
            }
        } else {
            self.isHidden = false
            self.alpha = 1
        }
    }
    
    /// 제약 재 조정 + 애니메이션 효과
    ///  - parameter updateConstraints: 제약 조건 업데이트 클로저 (ex: .remakeConstraints())
    ///  - parameter completion: 애니메이션 종료 후 실행할 클로저
    func remakeConstraintsWithAnimation(withDuration: CGFloat = 0.1, delay: TimeInterval = 0, options: UIView.AnimationOptions = .curveEaseInOut, updateConstraints: (() -> ())? = nil, completion: (() -> ())? = nil) {
        UIView.animate(withDuration: withDuration, delay: delay, options: options, animations: {
            updateConstraints?()
            /// - warning: View를 감싼 상위 뷰의 레이아웃을 다시 그려야함!
            self.superview?.layoutIfNeeded()
        }, completion: { _ in
            completion?()
        })
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

