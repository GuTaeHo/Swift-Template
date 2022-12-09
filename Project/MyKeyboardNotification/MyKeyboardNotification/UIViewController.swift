//
//  UIViewController.swift
//  MyKeyboardNotification
//
//  Created by 구태호 on 2022/12/09.
//

import UIKit

extension UIViewController {
    /// 키보드 옵저버 등록
    func addKeyboardObserver(show: Selector, hide: Selector) {
        NotificationCenter.default.addObserver(self, selector: show, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: hide, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // 키보드 옵저버 제거
    func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
