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
    
    /// 인디케이터 표시
    /// - parameter fileName: 표시할 json 형식의 파일
    func showIndicator(fileName: String = "ltLoading_1") {
        let animationView: LottieAnimationView = .init(name: fileName)
        animationView.tag = indicatorTag
        animationView.frame = view.bounds
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 1
        view.addSubview(animationView)
        animationView.play()
    }
    
    func hideIndicator() {
        if let indicatorView = view.viewWithTag(indicatorTag) {
            indicatorView.removeFromSuperview()
        }
    }
}
