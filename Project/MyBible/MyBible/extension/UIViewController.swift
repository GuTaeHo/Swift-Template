//
//  UIViewController.swift
//  MyCustomView
//
//  Created by 구태호 on 2023/03/09.
//

import UIKit

extension UIViewController {
    // TODO: paddingView 및 방향에 따라 토스트 위치 변경하기
    /// 토스트 표시
    /// - parameter message: 메시지 내용
    /// - parameter paddingView: 해당 뷰를 제외한 영역에 토스트 표시
    /// - parameter bottomView: 하단 영역을 차지하고 있는 뷰
    /// - note:
    func showToast(message: String, bottomPadding: CGFloat? = nil, bottomView: UIView? = nil) {
        let toastLabel = ToastLabel()
        toastLabel.backgroundColor = UIColor(r: 51, g: 51, b: 51, a: 1)
        toastLabel.lineBreakMode = .byWordWrapping
        toastLabel.textColor = .white
        toastLabel.font = UIFont.systemFont(ofSize: 16)
        toastLabel.numberOfLines = 0
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.sizeToFit()
        toastLabel.layer.cornerRadius = 18
        toastLabel.clipsToBounds = true
        toastLabel.isUserInteractionEnabled = false
        
        let DEFAULT_BOTTOM_PADDING: CGFloat = 32
        let height = toastLabel.sizeThatFits(CGSize(width: toastLabel.frame.width, height: CGFloat.greatestFiniteMagnitude)).height + 24
        
        self.view.addSubview(toastLabel)
        self.view.bringSubviewToFront(toastLabel)
        
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let toastWidthConstrains = toastLabel.widthAnchor.constraint(equalToConstant: toastLabel.intrinsicContentSize.width)
        let toastHeightConstrains = toastLabel.heightAnchor.constraint(equalToConstant: height)
        var toastBottomConstrains: NSLayoutConstraint!
        /// - note: bottomView 가 지정되어있다면 해당 뷰의 상단과 맞춤, 없다면 뷰 컨트롤러의 하단과 맞춤
        if let bottomView = bottomView {
            /// - note: 키보드 높이가 지정되어있지 않다면
            if bottomPadding == 0 {
                toastBottomConstrains = toastLabel.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: -(bottomPadding ?? 0) - DEFAULT_BOTTOM_PADDING)
            } else {
                toastBottomConstrains = toastLabel.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: -(bottomPadding ?? 0) - DEFAULT_BOTTOM_PADDING + bottomView.frame.height)
            }
        } else {
            toastBottomConstrains = toastLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(bottomPadding ?? 0) - DEFAULT_BOTTOM_PADDING)
        }
        let toastCenterXConstrains = toastLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        
        NSLayoutConstraint.activate([
            toastWidthConstrains,
            toastHeightConstrains,
            toastBottomConstrains,
            toastCenterXConstrains
        ])
        
        view.layoutIfNeeded()
        
        let TOAST_MAX_WIDTH_PADDING: CGFloat = 36.0
        let toastMaxWidth = UIScreen.main.bounds.width - 36 - TOAST_MAX_WIDTH_PADDING
        
        // 토스트가 기기 너비에 도달하면...
        if toastLabel.frame.width > toastMaxWidth {
            // 너비, 높이 제약 해제
            toastWidthConstrains.isActive = false
            toastHeightConstrains.isActive = false
            toastLabel.widthAnchor.constraint(equalToConstant: toastMaxWidth).isActive = true
            // MARK: 너비가 반영되어야 높이가 변경됨!!
            view.layoutIfNeeded()
            toastLabel.heightAnchor.constraint(equalToConstant: toastLabel.intrinsicContentSize.height).isActive = true
        }
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3,
                           delay: 2.0,
                           options: .curveEaseOut,
                           animations: { toastLabel.alpha = 0.0 }) { _ in
                toastLabel.removeFromSuperview()
            }
        }
    }
    
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
