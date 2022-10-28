//
//  CardViewUtil.swift
//  MyBottomCardView
//
//  Created by 구태호 on 2022/10/26.
//

import UIKit

class CardViewUtil {
    /// 하단 카드뷰 표시
    /// - Parameter context: 카드뷰가 표시될 UIViewController
    /// - Parameter contentView: 카드뷰의 콘텐츠에 표시할 Custom UIView
    /// - Parameter isHandleVisible: 제스처 핸들 표시 여부 (default: false)
    /// - Parameter cornerRadius: 상단 모서리 라운딩 값 (default: 24.0)
    /// - Parameter isCancelButtonVisible: 취소 버튼 표시 여부 (default: false)
    /// - Parameter cancelText: 취소 버튼 텍스트 (default: "취소")
    /// - Parameter cancelClosure: 취소 버튼 클릭 시 실행할 동작
    /// - Parameter isSubmitButtonVisible: 확인 버튼 표시 여부 (default: false)
    /// - Parameter submitText: 확인 버튼 텍스트 (default: "확인")
    /// - Parameter submitClosure: 확인 버튼 클릭 시 실행할 동작
    public static func showCardViewController(context: UIViewController, contentView: UIView, isHandleVisible: Bool = false, cornerRadius: CGFloat = 24.0, isCancelButtonVisible: Bool = false, cancelText: String = "취소", cancelClosure: (() -> ())? = nil, isSubmitButtonVisible: Bool = false, submitText: String = "확인",  submitClosure: (() -> ())? = nil) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "BottomCardViewController") as? BottomCardViewController {
            
            viewController.customContentView = contentView
            viewController.isHandleVisible = isHandleVisible
            viewController.cornerRadius = cornerRadius
            viewController.isCancelButtonVisible = isCancelButtonVisible
            viewController.cancelText = cancelText
            viewController.cancelCompletion = cancelClosure
            viewController.isSubmitButtonVisible = isSubmitButtonVisible
            viewController.submitText = submitText
            viewController.submitCompletion = submitClosure
            
            viewController.modalTransitionStyle = .crossDissolve
            viewController.modalPresentationStyle = .overFullScreen
            
            context.present(viewController, animated: true)
        }
    }
}
