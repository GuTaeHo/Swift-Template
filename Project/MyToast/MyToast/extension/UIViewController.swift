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
    /// - parameter paddingView: 해당 뷰를 제외한 영역에 토스트 표시
    // TODO: paddingView 및 방향에 따라 토스트 위치 변경하기
    func showToast(message: String, paddingView: UIView? = nil) {
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
        
        let DEFAULT_BOTTOM_PADDING: CGFloat = 64
        let height = toastLabel.sizeThatFits(CGSize(width: toastLabel.frame.width, height: CGFloat.greatestFiniteMagnitude)).height + 24
        
        self.view.addSubview(toastLabel)
        self.view.bringSubviewToFront(toastLabel)
        
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let toastWidthConstrains = toastLabel.widthAnchor.constraint(equalToConstant: toastLabel.intrinsicContentSize.width)
        let toastHeightConstrains = toastLabel.heightAnchor.constraint(equalToConstant: height)
        // - note: paddingView 가 지정되어있다면 해당 뷰의 상단과 맞춤, 없다면 뷰 컨트롤러의 하단과 맞춤
        let toastBottomConstrains = toastLabel.bottomAnchor.constraint(equalTo: paddingView?.topAnchor ?? view.bottomAnchor, constant: -DEFAULT_BOTTOM_PADDING)
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
            print("최대 라벨 높이 \(toastLabel.intrinsicContentSize.height)")
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
        
        /*
        // 애니메이션 중 호출
        let animateClosure = {
            toastLabel.alpha = 1.0
        }
        
        // 애니메이션 종료 후 호출
        let animateCompleteClosure: (Bool) -> () = { isFinished in
            if isFinished {
                UIView.animate(withDuration: 0.5, animations: {
                    toastLabel.alpha = 0.0
                    toastLabel.transform = CGAffineTransform(scaleX: 0, y: 0)
                    self.view.layoutIfNeeded()
                }) { _ in
                    toastLabel.removeFromSuperview()
                }
            }
        }
        
        UIView.animate(withDuration: 2.0,
                       animations: animateClosure, completion: animateCompleteClosure)
         */
    }
    
    
    func showToastCenter(message: String) {
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
        
        let height = toastLabel.sizeThatFits(CGSize(width: toastLabel.frame.width, height: CGFloat.greatestFiniteMagnitude)).height + 24
        
        self.view.addSubview(toastLabel)
        self.view.bringSubviewToFront(toastLabel)
        
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let toastWidthConstrains = toastLabel.widthAnchor.constraint(equalToConstant: toastLabel.intrinsicContentSize.width)
        let toastHeightConstrains = toastLabel.heightAnchor.constraint(equalToConstant: height)
        let toastCenterXConstrains = toastLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let toastCenterYConstrains = toastLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        
        NSLayoutConstraint.activate([
            toastWidthConstrains,
            toastHeightConstrains,
            toastCenterXConstrains,
            toastCenterYConstrains
        ])
        
        view.layoutIfNeeded()
        
        let toastMaxWidth = UIScreen.main.bounds.width - 72
        
        // 토스트가 기기 너비에 도달하면...
        if toastLabel.frame.width > toastMaxWidth {
            // 너비, 높이 제약 해제
            toastWidthConstrains.isActive = false
            toastHeightConstrains.isActive = false
            toastLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36).isActive = true
            toastLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36).isActive = true
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
