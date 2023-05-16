//
//  ResizableImageView.swift
//  MyUrlImageFrameTest
//
//  Created by 구태호 on 2023/05/16.
//

import UIKit


class ResizableImageView: UIImageView {
    
    /// 해당 프로퍼티가 초기화 되는 순간 사이즈를 이미지 본래 사이즈에 맞게 변경
    override var image: UIImage? {
        didSet {
            guard let image = image else { return }
            
            let resizeConstraints = [
                self.heightAnchor.constraint(equalToConstant: image.size.height),
                self.widthAnchor.constraint(equalToConstant: image.size.width)
            ]
            
            if superview != nil {
                addConstraints(resizeConstraints)
            }
        }
    }
}
