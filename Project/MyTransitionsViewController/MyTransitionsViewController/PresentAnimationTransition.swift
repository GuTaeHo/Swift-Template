//
//  PresentAnimationTransition.swift
//  MyTransitionsViewController
//
//  Created by 구태호 on 2023/08/27.
//

import UIKit

class PresentAnimationTransition: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning {
    private enum Constants {
        static let duration = 0.6
        static let affineTransform = CGAffineTransform(scaleX: 0.9, y: 0.9)
    }
    
    // 애니메이션 동작시간
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Constants.duration
    }
    
    // 애니메이션 효과
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // 1. 애니메이션에 적용할 뷰 획득
        let containerView = transitionContext.containerView
        guard let toView = transitionContext.view(forKey: .to) else { return }
        containerView.addSubview(toView)
        containerView.bringSubviewToFront(toView)
        
        // 2. 초기 위치 설정
        toView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            toView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            toView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            toView.topAnchor.constraint(equalTo: containerView.topAnchor),
        ])
        
        // 3. 커스텀 애니메이션 정의
        UIView.animateKeyframes(
            withDuration: Constants.duration,
            delay: 0,
            animations: {
                UIView.addKeyframe(
                    withRelativeStartTime: 0 / 2,
                    relativeDuration: 1 / 2,
                    animations: {
                        toView.transform = Constants.affineTransform
                    }
                )
                UIView.addKeyframe(
                    withRelativeStartTime: 1 / 2,
                    relativeDuration: 1 / 2,
                    animations: {
                        toView.transform = .identity
                    }
                )
            },
            completion: { transitionContext.completeTransition($0) }
        )
    }
}
