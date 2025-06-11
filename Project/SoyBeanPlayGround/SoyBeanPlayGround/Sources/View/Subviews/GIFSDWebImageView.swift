//
//  GIFSDWebImageView.swift
//  SoyBeanPlayGround
//
//  Created by 구태호 on 4/3/25.
//

import SwiftUI
//import SDWebImage


struct GIFSDWebImageView: UIViewRepresentable {
    var imageURL: String
    
    func makeUIView(context: Context) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        if let url = URL(string: imageURL) {
//            imageView.sd_setImage(with: url)
        }
        return imageView
    }
    
    func updateUIView(_ uiView: UIImageView, context: Context) {
        uiView.image = UIImage(named: imageURL)
    }
}
//
//class SDWebImageViewUIKitView: UIImageView {
//    override init(image: UIImage?) {
//        super.init(image: image)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
