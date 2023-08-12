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
    
    lazy var layoutMarginsTestStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .gray
        stackView.axis = .vertical
        stackView.layer.cornerRadius = 12
        stackView.layoutMargins = UIEdgeInsets(top: 12, left: 18, bottom: 12, right: 18)
        // MARK: 스택뷰의 레이아웃 마진 활성화
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 12
        
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(layoutMarginsTestStackView)
        
        layoutMarginsTestStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        layoutMarginsTestStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        layoutMarginsTestStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        for _ in 0...5 {
            let layoutMarginsTestViewInStackView: UIView = {
                let view = UIView()
                view.layer.cornerRadius = 12
                view.backgroundColor = .systemIndigo
                view.translatesAutoresizingMaskIntoConstraints = false
                view.layoutMargins = .init(top: 6, left: 12, bottom: 6, right: 12)
               
                return view
            }()
            
            layoutMarginsTestStackView.addArrangedSubview(layoutMarginsTestViewInStackView)
            layoutMarginsTestViewInStackView.heightAnchor.constraint(equalToConstant: 80).isActive = true
            // 뷰에 제스쳐 등록
            layoutMarginsTestViewInStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickedViewInStackview(_:))))
        }
        
        
        
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
    
    // 스택 뷰에서 제거
    @objc func clickedViewInStackview(_ sender: UITapGestureRecognizer) {
        // dump(sender)
        layoutMarginsTestStackView.removeFromStackView(view: sender.view)
        // layoutMarginsTestStackView.removeAllViewsInStackView()
    }
}

