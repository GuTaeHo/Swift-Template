//
//  UIViewController.swift
//  MyLottie
//
//  Created by 구태호 on 2022/12/18.
//

import UIKit
import Lottie

extension UIViewController {
    var indicatorTag: Int {
        get {
            return 3717
        }
    }
    
    var checkIndicatorTag: Int {
        get {
            return 966
        }
    }
    
    /// 인디케이터 표시
    /// - parameter fileName: 표시할 json 형식의 파일
    func showIndicator(fileName: String = "ltLoading_1") {
        let animationView: LottieAnimationView = .init(name: fileName)
        animationView.tag = indicatorTag
        animationView.frame = view.bounds
        animationView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 1
        
        view.addSubview(animationView)
        animationView.play()
    }
    
    func checkIndicator() {
        /// - warning: 애니메이션이 표시중일 경우 진행 X
        if view.viewWithTag(checkIndicatorTag) != nil {
            return
        }
        
        let animationView: LottieAnimationView = .init(name: "check")
        animationView.tag = checkIndicatorTag
        animationView.frame = CGRect(x: 0, y: 0, width: view.bounds.width / 2, height: view.bounds.width / 2)
        animationView.center = view.center
        animationView.backgroundColor = .clear
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.animationSpeed = 1.5
        
        view.addSubview(animationView)
        animationView.play { [weak self] isFinish in
            if isFinish {
                self?.hideCheckIndicator()
            }
        }
    }
    
    func hideIndicator() {
        if let indicatorView = view.viewWithTag(indicatorTag) {
            indicatorView.removeFromSuperview()
        }
    }
    
    func hideCheckIndicator() {
        if let backgroundView = view.viewWithTag(checkIndicatorTag) {
            UIView.animate(withDuration: 0.2, animations: {
                backgroundView.alpha = 0.0
            }, completion: { _ in
                backgroundView.removeFromSuperview()
            })
        }
    }
}
