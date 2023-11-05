//
//  ViewController.swift
//  MyUIImage
//
//  Created by 구태호 on 11/5/23.
//

import UIKit


/**
 - UIImage RenderingMode 란?
 UIImage의 값을 원본과 같이 색상이 있는 것으로 표현할 것인지, 원본 색상을 지운 형태만 가져갈 것인지 선택
 1. automatic: 컨텍스트의 기본 모드를 선택하며 지정해주지 않을 경우 디폴트 값 (보통 alwaysOriginal)
 2. alwaysOriginal: 원본 이미지 그대로 그림
 3. alwaysTemplate: 원본 이미지의 컬러 정보를 모두 없애고, 불투명한 부분만 tintColor로 표시
 
 */

class ViewController: UIViewController {
    
    lazy var imageView: ColorChangableImageView = {
        let imageView = ColorChangableImageView(image: UIImage(resource: .transperant), tintColor: .orange)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}


@available(iOS 17, *)
#Preview("Opaque Image View", traits: .defaultLayout) {
    let imageView = UIImageView()
    imageView.image = UIImage(resource: .opaque).withRenderingMode(.alwaysTemplate)
    imageView.tintColor = .green
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
}

@available(iOS 17, *)
#Preview("Transparent Image View", traits: .defaultLayout) {
    let imageView = UIImageView()
    imageView.image = UIImage(resource: .transperant).withRenderingMode(.alwaysTemplate)
    imageView.tintColor = .green
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
}

// 커스텀 뷰로 변경
@available(iOS 17, *)
#Preview("Transparent Image View", traits: .defaultLayout) {
    let imageView = ColorChangableImageView(image: .init(resource: .opaque), tintColor: .orange)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
}

@available(iOS 17, *)
#Preview("Transparent Image View", traits: .defaultLayout) {
    let imageView = ColorChangableImageView(image: .init(resource: .transperant), tintColor: .orange)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
}


//extension UIImageView {
//    override open func awakeFromNib() {
//        super.awakeFromNib()
//        tintColorDidChange()
//    }
//}
