//
//  ViewController.swift
//  MyUIStackView
//
//  Created by 구태호 on 4/16/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    lazy var stackView = UIStackView(axis: .vertical, spacing: 12, margins: .init(horizontal: 12, vertical: 18), subviews: [aView, bView])
    let aView = UIView(backgroundColor: .systemPink)
    let bView = UIView(backgroundColor: .systemIndigo)
    
    lazy var dynamicBottomAlignmentStackView = UIStackView(axis: .horizontal, spacing: 12, alignment: .bottom, distribution: .fillEqually, margins: .init(horizontal: 12, vertical: 18), subviews: [cView, dView, eView])
    
    let cView = UIView(backgroundColor: .systemGreen)
    let dView = UIView(backgroundColor: .systemYellow)
    let eView = UIView(backgroundColor: .systemPink)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initStackView()
        initDynamicBottomAlignmentStackView()
    }
    
    func initStackView() {
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        aView.snp.makeConstraints {
            $0.height.equalTo(80)
        }
        
        bView.snp.makeConstraints {
            $0.height.equalTo(80)
        }
    }
    
    func initDynamicBottomAlignmentStackView() {
        view.addSubview(dynamicBottomAlignmentStackView)
        NSLayoutConstraint.activate([
            dynamicBottomAlignmentStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            dynamicBottomAlignmentStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            dynamicBottomAlignmentStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        cView.snp.makeConstraints {
            $0.height.equalTo(20)
        }
        
        dView.snp.makeConstraints {
            $0.height.equalTo(60)
        }
        
        eView.snp.makeConstraints {
            $0.height.equalTo(40)
        }
    }
}

