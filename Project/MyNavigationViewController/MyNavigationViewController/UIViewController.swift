//
//  UIViewController.swift
//  MyNavigationViewController
//
//  Created by 구태호 on 2022/11/02.
//

import UIKit

extension UIViewController {
    /// <T> 에 해당하는 UIViewController 를 UIStoryboard 에서 찾아서 반환 (새 뷰 컨트롤러 생성)
    /// - parameter storyboardName: 해당 <T> 가 존재하는 Storyboard 명
    /// - parameter viewController: 생성하고 싶은 뷰 컨트롤러 타입 (ex: MainViewController().self)
    /// - returns: UIViewController?
    func viewController<T: UIViewController>(storyboardName: String, viewController: T) -> UIViewController? {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let identifier = String(describing: T.self)
        
        if let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as? T {
            // LogUtil.print(message: "\(T.self)", context: self, methodName: "viewController")
            return viewController
        } else {
            return nil
        }
    }
}
