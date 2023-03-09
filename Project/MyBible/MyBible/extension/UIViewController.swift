//
//  UIViewController.swift
//  MyCustomView
//
//  Created by 구태호 on 2023/03/09.
//

import UIKit

extension UIViewController {
    private func addActionForEndEditing() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    @objc func endEditing(_ gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    /// 키보드 옵저버 등록
    /// - parameter showKeyboardSelector: 키보드가 보여질 때 호출되는 objc 메소드 작성
    /// - parameter hideKeyboardSelecore: 키보드가 사라질 때 호출되는 objc 메소드 작성
    /// - note: 해당 메소드는 오버라이딩 불가능함 (final)
    final func addKeyboardObserver(showKeyboardSelector: Selector, hideKeyboardSelector: Selector) {
        NotificationCenter.default.addObserver(self, selector: showKeyboardSelector, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: hideKeyboardSelector, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    /// 키보드 옵저버 제거
    /// - note: 해당 메소드는 오버라이딩 불가능함 (final)
    final func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    /// T 에 해당하는 UIViewController 를 UIStoryboard 에서 찾아서 반환 (새 뷰 컨트롤러 생성)
    /// - parameter storyboardName: 해당 T 가 존재하는 Storyboard 명
    /// - parameter viewController: 생성하고 싶은 뷰 컨트롤러 타입 (ex: MainViewController().self)
    /// - returns: T?
    func viewController<T: UIViewController>(storyboardName: String, viewController: T) -> T? {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let identifier = String(describing: T.self)
        
        if let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as? T {
            return viewController
        } else {
            return nil
        }
    }
    /// SafeArea 크기 반환
    /// - parameter direction: 사이즈를 얻고싶은 방향 입력 (top, bottom, leading, trailing)
    func safeAreaSize(direction: UIView.Direction) -> CGFloat? {
        guard
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let safeAreaInsets = windowScene.windows.first?.safeAreaInsets
        else {
            return nil
        }
        
        switch direction {
        case .top:
            return safeAreaInsets.top
            
        case .bottom:
            return safeAreaInsets.bottom
            
        case .left:
            return safeAreaInsets.left
            
        case .right:
            return safeAreaInsets.right
        }
    }
}
