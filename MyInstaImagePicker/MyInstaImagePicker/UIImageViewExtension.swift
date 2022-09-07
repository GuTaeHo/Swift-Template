//
//  UIImageViewExtension.swift
//  MyInstaImagePicker
//
//  Created by 구태호 on 2022/07/17.
//

import UIKit

extension UIImageView {
    // 클릭 애니메이션이 적용된 탭 이벤트 등록 시 사용
    func enableTap(tag: String? = nil, _ closure: ((String?) -> Void)? = nil) {
        let tapGesture = CocobeanTapGesture(target: self, action: #selector(tap))
        // 전달된 태그 전달
        tapGesture.tag = tag
        // 전달된 클로저 전달
        tapGesture.closure = closure
        
        isUserInteractionEnabled = true
        addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func tap(_ sender: CocobeanTapGesture) {
        self.showAnimation {
            // 전달된 클로저가 있다면 실행
            sender.closure?(sender.tag)
        }
    }
    
    func enableZoom() {
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(startZooming(_:)))
        isUserInteractionEnabled = true
        addGestureRecognizer(pinchGesture)
    }
    
    @objc
    private func startZooming(_ sender: UIPinchGestureRecognizer) {
        let scaleResult = sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)
        
        // 사이즈 0.75 ~ 2 배 사이
        guard
            let scale = scaleResult, scale.a > 0.75, scale.d > 0.75, scale.a < 2, scale.d < 2
        else { return }
        sender.view?.transform = scale
        sender.scale = 1
    }
}
