//
//  UIViewController+.swift
//  MyViewControllerProtocol
//
//  Created by 구태호 on 2023/07/23.
//

import UIKit


extension UIViewController {
    // MARK: 모달 형태로만 구현된 프로젝트에서 상위 뷰 컨트롤러를 찾을 때 사용
    /// 상위 뷰 컨트롤러 반환
    /// - warning: 모달 형태로 표시된 뷰 컨트롤러만 획득 가능
    func parent<T: UIViewController>(type: T.Type) -> UIViewController? {
        var parent = presentingViewController
        
        while parent != nil  {
            if let parent = parent as? T {
                return parent
            }
            
            parent = parent?.presentingViewController
        }
        
        
        return nil
    }
}
