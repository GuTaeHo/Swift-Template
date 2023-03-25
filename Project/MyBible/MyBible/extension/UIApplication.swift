//
//  UIApplication.swift
//  MyBible
//
//  Created by 구태호 on 2023/03/25.
//

import UIKit


extension UIApplication {
    /// 현재 표시되고 있는 최상위 뷰 컨트롤러 반환
    class func topViewController(base: UIViewController? = nil) -> UIViewController? {
        var baseViewController = base
        
        if baseViewController == nil {
            let scenes = UIApplication.shared.connectedScenes
            let windowScene = scenes.first as? UIWindowScene
            let window = windowScene?.windows.first
            baseViewController = window?.rootViewController
        }
        
        /* 현재 */
        if let nav = baseViewController as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = baseViewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = baseViewController?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}
