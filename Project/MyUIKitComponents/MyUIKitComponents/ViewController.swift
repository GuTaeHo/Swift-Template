//
//  ViewController.swift
//  MyUIKitComponents
//
//  Created by 구태호 on 2022/12/19.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        var tintConfiguration = UIButton.Configuration.tinted()
        tintConfiguration.image = UIImage(systemName: "pencil.tip")
        let tintButton = UIButton(configuration: tintConfiguration)
        // 틴트 버튼 타이틀 지정
        var tintButtonTitleAttr = AttributedString.init("UIButton")
        tintButtonTitleAttr.font = .systemFont(ofSize: 26.0, weight: .heavy)
        tintButton.configuration?.attributedTitle = tintButtonTitleAttr
        // 틴트 버튼 서브타이틀 지정
        var tintButtonSubTitleAttr = AttributedString.init("예제로 이동")
        tintButtonSubTitleAttr.font = .systemFont(ofSize: 20.0, weight: .light)
        tintButton.configuration?.attributedSubtitle = tintButtonTitleAttr
        tintButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tintButton)
        
        // MARK: Safe Area 가이드 영역에 맞춰 오토 레이아웃 업데이트
        print(view.safeAreaInsets)
        print(view.safeAreaLayoutGuide)
        print(view.safeAreaLayoutGuide.layoutFrame)
        let safeAreaGuide = view.safeAreaLayoutGuide
        tintButton.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 18).isActive = true
        tintButton.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 18).isActive = true
        tintButton.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -18).isActive = true
        
        let tintButtonTapGesture = UITapGestureRecognizer(target: self, action: #selector(tintButtonTap))
        tintButton.addGestureRecognizer(tintButtonTapGesture)
    }
    
    @objc func tintButtonTap() {
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "UIButtonViewController") {
            present(viewController, animated: true)
        }
    }
}

