//
//  UIWindow.swift
//  MyCustomView
//
//  Created by 구태호 on 2023/03/09.
//

import UIKit


extension UIWindow {
    public var visibleViewController: UIViewController? {
        return self.getRootViewController(vc: self.rootViewController)
    }
    
    private func getRootViewController(vc: UIViewController?) -> UIViewController? {
        
        guard let vc = vc else {
            return nil
        }
        
        ///[1] 네비게이션 컨트롤러
        if let nc = vc as? UINavigationController {
            
            if let vcOfnavController = nc.visibleViewController {
                return self.getRootViewController(vc: vcOfnavController)
            }
            
        ///[2] 탭뷰 컨트롤러
        } else if let tc = vc as? UITabBarController {
            
            if let tcOfnavControler = tc.selectedViewController {
                return self.getRootViewController(vc: tcOfnavControler)
            }
            
        ///[3] 뷰 컨트롤러
        } else {
            if let pvc = vc.presentedViewController {
                return self.getRootViewController(vc: pvc)
            } else {
                return vc
            }
        }
        
        return nil
    }
}
