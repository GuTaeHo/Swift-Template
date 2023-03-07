//
//  UIViewController.swift
//  MyToast
//
//  Created by 구태호 on 2023/03/07.
//

import UIKit

extension UIViewController {
    /// 토스트 표시
    /// - parameter message: 메시지 내용
    /// - parameter paddingView:
    func showToast(message: String, paddingView: UIView? = nil) {
        
    }
    
    /// 스낵바 표시
    func showSnackbar(message: String) {
        
    }
    
    /// 키보드 옵저버 등록
    /// - warning: 뷰 컨트롤러 생성 시 호출해줘야함!
    func addKeyboardObserver(show: Selector, hide: Selector) {
        NotificationCenter.default.addObserver(self, selector: show, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: hide, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    /// 키보드 옵저버 제거
    /// - warning: 뷰 컨트롤러 제거 시 호출해줘야함!
    func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
