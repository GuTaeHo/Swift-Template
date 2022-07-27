//
//  Blur.swift
//  MyUIComponents
//
//  Created by 구태호 on 2022/07/24.
//

import UIKit

extension UIView {
    /// 블러 효과 적용
    func blur() {
        let blurredView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        blurredView.frame = self.bounds
        self.addSubview(blurredView)
    }
}
