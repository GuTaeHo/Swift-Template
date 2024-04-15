//
//  UIViewController.swift
//  MyKeyboardNotification
//
//  Created by 구태호 on 2022/12/09.
//

import UIKit
import Combine

extension UIViewController {
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
    
    /// 키보드 높이가 변경될 경우 키보드 높이를 방출하는 퍼블리셔를 생성합니다.
    var keyboardPublisher: AnyPublisher<CGFloat, Never> {
        let willShowPublisher = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
        let willHidePublisher = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
        
        let mergedPublisher = willShowPublisher
            .merge(with: willHidePublisher)
            .compactMap { notification in
                guard
                    let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
                    let screenHeight = UIApplication.shared.delegate?.window??.screen.bounds.size.height, screenHeight > 0
                else {
                    return CGFloat(0)
                }
                
                if keyboardFrame.cgRectValue.minY < screenHeight {
                    return keyboardFrame.cgRectValue.height
                } else {
                    return CGFloat(0)
                }
            }
        return mergedPublisher.eraseToAnyPublisher()
    }
}
