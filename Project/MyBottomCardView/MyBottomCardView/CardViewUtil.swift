//
//  CardViewUtil.swift
//  MyBottomCardView
//
//  Created by 구태호 on 2022/10/26.
//

import UIKit

class CardViewUtil {
    /// 하단 카드뷰 표시
    /// - parameters isHandleVisible: 제스처 핸들 표시 여부 (default: false)
    public static func showCardViewController(context: UIViewController, isHandleVisible: Bool = false) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "BottomCardViewController") as? BottomCardViewController {
            
            viewController.isHandleVisible = isHandleVisible
                
            context.present(viewController, animated: true)
        }
    }
}
