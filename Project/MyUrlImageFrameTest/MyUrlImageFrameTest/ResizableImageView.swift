//
//  ResizableImageView.swift
//  MyUrlImageFrameTest
//
//  Created by 구태호 on 2023/05/16.
//

import UIKit


class ResizableImageView: UIImageView {
    
    /// 이미지 고유 사이즈를 너비에 맞게 높이를 조정하여 반환
    override var intrinsicContentSize: CGSize {
        
        if let myImage = self.image {
            let myImageWidth = myImage.size.width
            let myImageHeight = myImage.size.height
            let myViewWidth = self.frame.size.width
            
            let ratio = myViewWidth/myImageWidth
            let scaledHeight = myImageHeight * ratio
            
            return CGSize(width: myViewWidth, height: scaledHeight)
        }
        
        return CGSize(width: -1.0, height: -1.0)
    }
}
