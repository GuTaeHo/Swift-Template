//
//  UIView+.swift
//  MyUIResponder
//
//  Created by 구태호 on 11/7/23.
//

import UIKit


extension UIView {
    /// 현재 뷰를 가진 뷰 컨트롤러를 반환
    /// - Note: Responder Chain 을 탐색하여 Responder 가 UIContoller 일 경우 반환
    var viewController: UIViewController? {
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.sharedText.append("\(next ?? .init())\n\n")
        }
        print(next ?? .init())
        /// `다음 Responder 가 UIViewController 인지 검사합니다.`
        if let vc = self.next as? UIViewController {
            NotificationCenter.default.post(name: .post, object: nil)
            return vc
        } else if let superView = self.superview {
            return superView.viewController
        } else {
            return nil
        }
    }
}


extension NSNotification.Name {
    static let post = Notification.Name("post")
}
