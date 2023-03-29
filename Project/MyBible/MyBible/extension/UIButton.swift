//
//  UIButton.swift
//  MyBible
//
//  Created by 구태호 on 2023/03/14.
//

import UIKit

extension UIButton {
    open override func awakeFromNib() {
        super.awakeFromNib()
        showIndicator()
        hideIndicator()
    }
    /// 인디케이터 표시
    /// - warning: 이미지 영역을 대신해 인디케이터 표시됨
    /// - warning: 인디케이터 활성화 중 상호작용 불가
    func showIndicator() {
        self.isEnabled = false
        self.configuration?.showsActivityIndicator = true
    }
    
    /// 인디케이터 숨김
    func hideIndicator() {
        self.isEnabled = true
        self.configuration?.showsActivityIndicator = false
    }
    
    /// 탭 액션 등록
    /// - parameter isIndicate: 버튼 인디케이터 표시 여부
    /// - parameter action: 뷰 클릭 시 호출될 클로저
    func addAction(isIndicate: Bool, action: @escaping () -> ()) {
        let recognizer = ButtonTapGestureRecognizer(target: self, action: #selector(self.buttonTapGesture(_:)))
        recognizer.indicated = isIndicate
        recognizer.action = action
        
        recognizer.numberOfTapsRequired = 1
        recognizer.numberOfTouchesRequired = 1
        
        self.addGestureRecognizer(recognizer)
        self.isUserInteractionEnabled = true
    }
    
    @objc func buttonTapGesture(_ sender: ButtonTapGestureRecognizer) {
        if sender.indicated {
            self.showIndicator()
        }
        sender.action?()
    }
}

/// 커스텀 버튼 탭 인식기
class ButtonTapGestureRecognizer: UITapGestureRecognizer {
    var indicated: Bool = false
    var action: (() -> ())? = nil
}
