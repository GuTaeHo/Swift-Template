//
//  DismissAnimationTransition.swift
//  MyTransitionsViewController
//
//  Created by 구태호 on 2023/08/27.
//

import UIKit

final class DismissAnimationTransition: NSObject {
    private enum Constants {
        static let duration = 0.5
        static let affineTransform = CGAffineTransform(scaleX: 0.5, y: 0.5)
    }
}

extension DismissAnimationTransition: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Constants.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // 사라지는 뷰
        guard let fromView = transitionContext.view(forKey: .from) else { return }
        UIView.animate(
            withDuration: 0.5,
            animations: { fromView.alpha = 0 },
            completion: { completed in transitionContext.completeTransition(completed) }
        )
    }
}
