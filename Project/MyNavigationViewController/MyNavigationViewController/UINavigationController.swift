//
//  UINavigationController.swift
//  MyNavigationViewController
//
//  Created by 구태호 on 2022/11/24.
//

import UIKit

extension UINavigationController {
    /// 이전 뷰 컨트롤러 반환
    /// - parameter context: 이전 뷰 컨트롤러 타입
    /// - returns T
    func previousViewController<T>(context: T) -> T? {
        let viewController = viewControllers.count > 1 ? viewControllers[viewControllers.count - 2] : nil
        
        guard let viewController = viewController as? T else {
            return nil
        }
        
        return viewController
    }
}
