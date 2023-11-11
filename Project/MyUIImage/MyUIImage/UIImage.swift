//
//  UIImage.swift
//  MyUIImage
//
//  Created by 구태호 on 11/11/23.
//

import UIKit


extension UIImage {
    func resize(newWidth: CGFloat) -> UIImage {
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        
        let size = CGSize(width: newWidth, height: newHeight)
        let render = UIGraphicsImageRenderer(size: size)
        let renderImage = render.image { context in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
        
        print("압축 배율: \(Int(self.size.width / renderImage.size.width))배")
        print("화면 배율: \(UIScreen.main.scale)")// 배수
        print("원본: \(self.size), 압축됨: \(renderImage.size)")
        return renderImage
    }
}
