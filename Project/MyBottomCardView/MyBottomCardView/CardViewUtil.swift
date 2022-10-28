//
//  CardViewUtil.swift
//  MyBottomCardView
//
//  Created by 구태호 on 2022/10/26.
//

import UIKit

class CardViewUtil {
    /// 하단 카드뷰 표시
    /// - Parameter isHandleVisible: 제스처 핸들 표시 여부 (default: false)
    /// - Parameter cornerRadius: 상단 모서리 라운딩 값 (default: 0.0)
    /// - Parameter isCancelButtonVisible: 취소 버튼 표시 여부 (default: false)
    /// - Parameter cancelText: 취소 버튼 텍스트 (default: "취소")
    /// - Parameter cancelCompletion: 취소 버튼 클릭 시 실행할 동작
    /// - Parameter isSubmitButtonVisible: 확인 버튼 표시 여부 (default: false)
    /// - Parameter submitText: 확인 버튼 텍스트 (default: "확인")
    /// - Parameter submitCompletion: 확인 버튼 클릭 시 실행할 동작
    public static func showCardViewController(context: UIViewController, isHandleVisible: Bool = false, cornerRadius: CGFloat = 0.0, isCancelButtonVisible: Bool = false, cancelText: String = "취소", cancelCompletion: (() -> ())? = nil, isSubmitButtonVisible: Bool = false, submitText: String = "확인",  submitCompletion: (() -> ())? = nil) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "BottomCardViewController") as? BottomCardViewController {
            
            viewController.isHandleVisible = isHandleVisible
            viewController.cornerRadius = cornerRadius
            viewController.isCancelButtonVisible = isCancelButtonVisible
            viewController.cancelText = cancelText
            viewController.cancelCompletion = cancelCompletion
            viewController.isSubmitButtonVisible = isSubmitButtonVisible
            viewController.submitText = submitText
            viewController.submitCompletion = submitCompletion
            
            viewController.modalTransitionStyle = .crossDissolve
            viewController.modalPresentationStyle = .overFullScreen
            
            context.present(viewController, animated: true)
        }
    }
}
