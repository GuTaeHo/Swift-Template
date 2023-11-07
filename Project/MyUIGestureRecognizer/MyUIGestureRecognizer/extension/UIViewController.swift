//
//  UIViewController.swift
//  MyGesture
//
//  Created by 구태호 on 2023/03/03.
//

import UIKit

extension UIViewController {
    /// 토스트 메시지를 표시함
    /// - parameter message: 표시할 메시지
    /// - parameter position: 하단 간격 설정, 기본 64만큼 떨어져있음
    func showToast(message: String, position: CGFloat = 0) {
        let toastLabel = UILabel()
        toastLabel.backgroundColor = UIColor(r: 51, g: 51, b: 51, a: 1)
        toastLabel.lineBreakMode = .byWordWrapping
        toastLabel.textColor = UIColor(r: 242, g: 242, b: 242, a: 1)
        toastLabel.alpha = 0.95
        toastLabel.font = UIFont.systemFont(ofSize: 16)
        toastLabel.numberOfLines = 0
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.sizeToFit()
        toastLabel.clipsToBounds = true
        toastLabel.isUserInteractionEnabled = false
        
        let DEFAULT_BOTTOM_PADDING: CGFloat = 64
        let height = toastLabel.sizeThatFits(CGSize(width: toastLabel.frame.width, height: CGFloat.greatestFiniteMagnitude)).height + 24
        
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(toastLabel)
        self.view.bringSubviewToFront(toastLabel)
        
        // 제약 조건 일괄 활성화
        NSLayoutConstraint.activate([
            toastLabel.widthAnchor.constraint(equalToConstant: toastLabel.intrinsicContentSize.width + 36),
            toastLabel.heightAnchor.constraint(equalToConstant: height),
            toastLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -DEFAULT_BOTTOM_PADDING),
            toastLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
        toastLabel.layer.cornerRadius = height / 2
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3,
                           delay: 2.0,
                           options: .curveEaseOut,
                           animations: { toastLabel.alpha = 0.0 }) { _ in
                toastLabel.removeFromSuperview()
            }
        }
    }
}
