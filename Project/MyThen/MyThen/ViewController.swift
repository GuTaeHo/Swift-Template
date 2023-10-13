//
//  ViewController.swift
//  MyThen
//
//  Created by 구태호 on 2023/08/20.
//

import UIKit
import Then

class ViewController: UIViewController {
    lazy var setCGSizeBeforeAddSubViewView = UIView().then {
        $0.backgroundColor = .systemIndigo
        $0.translatesAutoresizingMaskIntoConstraints = false
        // MARK: addSubView 전 width & height 제약이 적용될까?
        $0.widthAnchor.constraint(equalToConstant: 300).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    lazy var stackViewForHiddenTest = UIStackView().then {
        $0.axis = .vertical
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    lazy var hiddenTestView = UIView().then {
        $0.backgroundColor = .red
        $0.widthAnchor.constraint(equalToConstant: 200).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 100).isActive = true
        // $0.translatesAutoresizingMaskIntoConstraints = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(setCGSizeBeforeAddSubViewView)
        
        // MARK: height 가 적용되어있는 상태에서 제약조건을 다시 할당했기 때문에 에러로그 출력, 시스템이 자동으로 height 제약조건을 제거
        NSLayoutConstraint.activate([
            setCGSizeBeforeAddSubViewView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            setCGSizeBeforeAddSubViewView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            setCGSizeBeforeAddSubViewView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        view.addSubview(stackViewForHiddenTest)
        stackViewForHiddenTest.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackViewForHiddenTest.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        
        stackViewForHiddenTest.addArrangedSubview(hiddenTestView)
        
        hiddenTestView.isHidden = false
        hiddenTestView.isHidden = false
        
        hiddenTestView.isHidden = true
    }
}

