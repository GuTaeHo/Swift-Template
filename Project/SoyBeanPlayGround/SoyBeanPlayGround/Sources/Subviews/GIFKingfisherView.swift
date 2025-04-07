//
//  GIFKingfisherView.swift
//  SoyBeanPlayGround
//
//  Created by 구태호 on 4/7/25.
//

import SwiftUI
import Kingfisher


struct GIFKingfisherView: UIViewRepresentable {
    var imageURL: String
    
    func makeUIView(context: Context) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        if let url = URL(string: imageURL) {
            imageView.kf.setImage(with: url)
        }
        return imageView
    }
    
    func updateUIView(_ uiView: UIImageView, context: Context) {
        uiView.image = UIImage(named: imageURL)
    }
}
