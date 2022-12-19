//
//  UIButtonViewController.swift
//  MyUIKitComponents
//
//  Created by 구태호 on 2022/12/19.
//

import UIKit

class UIButtonViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // iOS 15 부터 UIButton 의 Configuration 을 통해 관련 속성을 지정할 수 있게 됨.
        let tintConfiguration = UIButton.Configuration.tinted()
        let tintButton = UIButton(configuration: tintConfiguration)
        tintButton.configuration?.baseBackgroundColor = .red
        tintButton.configuration?.baseForegroundColor = .blue
        // 틴트 버튼 타이틀 지정
        var tintButtonTitleAttr = AttributedString.init("Tint Button Title")
        tintButtonTitleAttr.font = .systemFont(ofSize: 26.0, weight: .heavy)
        tintButton.configuration?.attributedTitle = tintButtonTitleAttr
        // 틴트 버튼 서브타이틀 지정
        var tintButtonSubTitleAttr = AttributedString.init("Tint Button Subtitle")
        tintButtonSubTitleAttr.font = .systemFont(ofSize: 20.0, weight: .light)
        tintButton.configuration?.attributedSubtitle = tintButtonTitleAttr
        let fillButton = UIButton(configuration: .filled())
        
        
        view.addSubview(tintButton)
        view.addSubview(fillButton)
        
        tintButton.translatesAutoresizingMaskIntoConstraints = false
        tintButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18).isActive = true
        tintButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 18).isActive = true
        tintButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -18).isActive = true
        
        fillButton.translatesAutoresizingMaskIntoConstraints = false
        fillButton.topAnchor.constraint(equalTo: tintButton.bottomAnchor, constant: 18).isActive = true
        fillButton.leftAnchor.constraint(equalTo: tintButton.leftAnchor, constant: 18).isActive = true
        fillButton.rightAnchor.constraint(equalTo: tintButton.rightAnchor, constant: 18).isActive = true
    }
}

import SwiftUI

struct ViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIButtonViewController

    func makeUIViewController(context: Context) -> UIButtonViewController {
        return UIButtonViewController()
    }

    func updateUIViewController(_ uiViewController: UIButtonViewController, context: Context) {
    }
}

@available(iOS 13.0.0, *)
struct ViewPreview: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable()
    }
}
