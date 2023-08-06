//
//  ViewController.swift
//  MyLayoutGuides
//
//  Created by 구태호 on 2023/08/06.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var layoutMarginsTestView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemIndigo
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layoutMargins = .init(top: 6, left: 12, bottom: 6, right: 12)
       
        return view
    }()
    
    lazy var layoutMarginsTestLabel: UILabel = {
        let label = UILabel()
        label.text = "layoutMargins 테스트 중..."
        label.backgroundColor = .orange
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: 스크롤 뷰의 contentInset 처럼 UIView 는 layoutMargins 속성이 존재
        // MARK: 해당 속성을 통해 뷰와 콘텐츠 사이에 패딩을 넣어줄 수 있다.
        layoutMarginsTestView.addSubview(layoutMarginsTestLabel)
        NSLayoutConstraint.activate([
            layoutMarginsTestLabel.topAnchor.constraint(equalTo: layoutMarginsTestView.layoutMarginsGuide.topAnchor),
            layoutMarginsTestLabel.bottomAnchor.constraint(equalTo: layoutMarginsTestView.layoutMarginsGuide.bottomAnchor),
            layoutMarginsTestLabel.leadingAnchor.constraint(equalTo: layoutMarginsTestView.layoutMarginsGuide.leadingAnchor),
            layoutMarginsTestLabel.trailingAnchor.constraint(equalTo: layoutMarginsTestView.layoutMarginsGuide.trailingAnchor)
        ])
        
        view.addSubview(layoutMarginsTestView)
        NSLayoutConstraint.activate([
            layoutMarginsTestView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            layoutMarginsTestView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            layoutMarginsTestView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

